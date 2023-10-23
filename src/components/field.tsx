type ChildProps = {
  msg: string;
};

const Field: React.FC<ChildProps> = ({ msg }) => {
  console.log('props : ', msg);
  return <p>Field: {msg}</p>;
};

export default Field;
