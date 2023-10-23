import { useEffect, useState } from 'react';
import { LoadObelisk } from '../tool';
import { WORLD_ID } from '../chain/config';

type ChildProps = {
  entity: string;
};

const Field: React.FC<ChildProps> = ({ entity }) => {
  console.log('props : ', entity);

  const [owner, setOwner] = useState('');
  const [fieldNumber, setFieldNumber] = useState(0);
  const [lastPlantNo, setLatPlantNo] = useState(0);
  const [plantKeys, setPlantKeys] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      const obelisk = await LoadObelisk();
      const content = await obelisk.getEntity(WORLD_ID, 'field_info', entity);
      console.log(content);
      setOwner(content[0]);
      setFieldNumber(content[1]);
      setLatPlantNo(content[2]);
    };
    fetchData();
  }, [entity]);

  const growPlant = async () => {
    const obelisk = await LoadObelisk();
    console.log(obelisk);
  };

  return (
    <div className="card bg-base-100 shadow-xl image-full m-2 float-left">
      <div className="card-body">
        <h2 className="card-title">Field : {fieldNumber}</h2>
        <p>Owner : {owner}</p>
        <div>
          Plants:
          <ul>
            {plantKeys.map(plantKey => {
              return <li key={plantKey}>{plantKey}</li>;
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
