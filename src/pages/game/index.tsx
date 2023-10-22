import { useEffect } from 'react';
import { useSetAtom } from 'jotai';
import { PlayerInfo, UserAddress, UserBalance } from '../../jotai';
import { Header } from '../../components';
import { LoadObelisk } from '../../tool';

const Game = () => {
  const setAddress = useSetAtom(UserAddress);
  const setBlance = useSetAtom(UserBalance);

  useEffect(() => {
    const asyncHandler = async () => {
      const obelisk = await LoadObelisk();
      let address = obelisk.getAddress();
      console.log(address);
      const balance = await obelisk.getBalance();
      setAddress(address);
      setBlance(balance.totalBalance);
      console.log(obelisk);
    };
    asyncHandler();
  }, [setAddress, setBlance]);

  return (
    <>
      <Header />
    </>
  );
};
export default Game;
