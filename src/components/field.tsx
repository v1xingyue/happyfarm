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

  useEffect(() => {
    const fetchData = async () => {
      const obelisk = await LoadObelisk();
      const content = await obelisk.getEntity(WORLD_ID, 'field_info', entity);
      console.log(content);
      setOwner(content[0]);
      setFieldNumber(content[1]);
    };
    fetchData();
  }, [entity]);

  return (
    <div className="card bg-base-100 shadow-xl image-full m-2 float-left">
      <div className="card-body">
        <h2 className="card-title">Field : {fieldNumber}</h2>
        <p>Owner : {owner}</p>
        <div>Plants: </div>
      </div>
    </div>
  );
};

export default Field;
