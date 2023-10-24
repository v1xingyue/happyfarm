import { useAtom, useAtomValue } from 'jotai';
import { FieldAddrs, WorldVersion } from '../jotai';
import { useEffect } from 'react';
import { LoadObelisk } from '../tool';
import { WORLD_ID } from '../chain/config';
import Field from './field';

const World = () => {
  const worldVersion = useAtomValue(WorldVersion);
  const [fieldAddrs, setFieldAddrs] = useAtom(FieldAddrs);

  useEffect(() => {
    const fetchFields = async () => {
      const obelisk = await LoadObelisk();
      const result = await obelisk.getEntity(WORLD_ID, 'global');
      if (result) {
        console.log('last field no: ', result[3]);
        let fieldAddrs = [];
        for (let i = 1000; i < result[3]; i++) {
          const fieldAddr = await obelisk.entity_key_from_u256(i);
          console.log('field: ', fieldAddr);
          fieldAddrs.push(fieldAddr);
        }
        if (fieldAddrs.length > 0) {
          setFieldAddrs(fieldAddrs);
        }
      }
    };
    fetchFields();
  }, [setFieldAddrs, worldVersion]);

  return (
    <div className="mt-3">
      {fieldAddrs.map((fieldAddr: string, index) => {
        return <Field key={fieldAddr} entity={fieldAddr} />;
      })}
    </div>
  );
};

export default World;
