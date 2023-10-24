import { useEffect, useState } from 'react';
import { LoadObelisk } from '../tool';
import { WORLD_ID } from '../chain/config';
import { TransactionBlock } from '@mysten/sui.js';
import { useAtom, useAtomValue } from 'jotai';
import { PlantUpdate, PlayerInfoVersion } from '../jotai';

type ChildProps = {
  entity: string;
  field: string;
};
const PlantDisplay: React.FC<ChildProps> = ({ entity, field }) => {
  const [playerInfoVersion, setPlayerInfoVersion] = useAtom(PlayerInfoVersion);
  const [harvested, setHarvested] = useState(false);
  const [score, setScore] = useState(0);
  const [displayVersion, setDisplayVersion] = useState(0);
  const plantUpdate = useAtomValue(PlantUpdate);
  const [plantTypeNo, setPlantTypeNo] = useState(0);

  useEffect(() => {
    const LoadPlant = async () => {
      const obelisk = await LoadObelisk();
      const content = await obelisk.getEntity(WORLD_ID, 'plant', entity);
      console.log(content);
      setScore(content[0]);
      setHarvested(content[3]);
      setPlantTypeNo(content[4]);
    };
    LoadPlant();
  }, [entity, displayVersion, plantUpdate, plantTypeNo]);

  const HarvsetPlant = async () => {
    const obelisk = await LoadObelisk();
    const tx = new TransactionBlock();
    const params = [tx.pure(WORLD_ID), tx.pure(field), tx.pure(entity)];
    console.log(params);
    const new_tx = await obelisk.tx.plant_system.harvest_plant(tx, params, true);
    const response = await obelisk.signAndSendTxn(new_tx as TransactionBlock);
    if (response.effects.status.status == 'success') {
      setDisplayVersion(displayVersion + 1);
      setPlayerInfoVersion(playerInfoVersion + 1);
    }
  };

  return (
    <div className="m-2">
      <div className="badge badge-info gap-2">{entity}</div>
      <div className="badge badge-success gap-2 ml-3">{plantTypeNo}</div>
      <div className="badge badge-secondary ml-3">{score}</div>
      {harvested ? (
        <> - </>
      ) : (
        <button onClick={HarvsetPlant} className="btn btn-info m-2">
          Harvest
        </button>
      )}
    </div>
  );
};

export default PlantDisplay;
