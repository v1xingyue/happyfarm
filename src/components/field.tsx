import { useEffect, useState } from 'react';
import { LoadObelisk } from '../tool';
import { WORLD_ID } from '../chain/config';
import { TransactionBlock } from '@mysten/sui.js';
import PlantDisplay from './plant_display';
import { useAtom, useSetAtom } from 'jotai';
import { PlantUpdate, PlayerInfoVersion } from '../jotai';

type ChildProps = {
  entity: string;
};

const Field: React.FC<ChildProps> = ({ entity }) => {
  console.log('props : ', entity);

  const [playerInfoVersion, setPlayerInfoVersion] = useAtom(PlayerInfoVersion);
  const [owner, setOwner] = useState('');
  const [fieldNumber, setFieldNumber] = useState(0);
  const [lastPlantNo, setLatPlantNo] = useState(0);
  const [plantKeys, setPlantKeys] = useState([]);
  const [displayVersion, setDisplayVersion] = useState(0);
  const [plantUpdate, setPlantUpdate] = useAtom(PlantUpdate);

  useEffect(() => {
    const fetchData = async () => {
      const obelisk = await LoadObelisk();
      const content = await obelisk.getEntity(WORLD_ID, 'field_info', entity);
      console.log(content);
      setOwner(content[0]);
      setFieldNumber(content[1]);
      setLatPlantNo(content[2]);
      const plantKeys = [];
      for (let i = 1000; i < lastPlantNo; i++) {
        plantKeys.push(await obelisk.entity_key_from_u256(i));
      }
      console.log(plantKeys);
      setPlantKeys(plantKeys);
      setPlayerInfoVersion(playerInfoVersion + 1);
    };
    fetchData();
  }, [entity, displayVersion, lastPlantNo]);

  const applySkill = async () => {
    console.log('apply skill...');
    let skillType = Math.floor(Math.random() * 4);
    alert(skillType);
    let obelisk = await LoadObelisk();
    const tx = new TransactionBlock();
    const params = [tx.pure(WORLD_ID), tx.pure(entity), tx.pure(skillType)];
    console.log(params);
    const new_tx = await obelisk.tx.field_system.apply_skill(tx, params, true);
    const response = await obelisk.signAndSendTxn(new_tx as TransactionBlock);
    if (response.effects.status.status == 'success') {
      setDisplayVersion(displayVersion + 1);
      setPlantUpdate(plantUpdate + 1);
    }
  };

  const growPlant = async () => {
    const obelisk = await LoadObelisk();
    const plant_type = await obelisk.entity_key_from_u256(18);
    const tx = new TransactionBlock();
    const params = [tx.pure(WORLD_ID), tx.pure(entity), tx.pure(plant_type)];
    console.log(params);
    const new_tx = await obelisk.tx.plant_system.grow_plant(tx, params, true);
    const response = await obelisk.signAndSendTxn(new_tx as TransactionBlock);
    if (response.effects.status.status == 'success') {
      setDisplayVersion(displayVersion + 1);
    }
  };

  return (
    <div className="card bg-base-100 shadow-xl image-full m-2 float-left">
      <div className="card-body">
        <h2 className="card-title">Field : {fieldNumber}</h2>
        <p>
          Owner : {owner}{' '}
          <button onClick={applySkill} className="btn btn-secondary ml-3">
            Hit Plant!!
          </button>{' '}
        </p>
        <div>
          Plants:
          <ul>
            {plantKeys.map(plantKey => {
              return (
                <li key={plantKey}>
                  <PlantDisplay entity={plantKey} field={entity} />
                </li>
              );
            })}
          </ul>
          <div className="card-actions justify-end">
            {plantKeys.length <= 3 && (
              <button onClick={growPlant} className="btn btn-primary">
                Grow
              </button>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default Field;
