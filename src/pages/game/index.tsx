import { useEffect } from 'react';
import { useAtomValue, useSetAtom } from 'jotai';
import { BalanceVersion, UserAddress, UserBalance } from '../../jotai';
import { Header, GameHeader } from '../../components';
import { LoadObelisk } from '../../tool';

const Game = () => {
  const blanceVersion = useAtomValue(BalanceVersion);
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
  }, [setAddress, setBlance, blanceVersion]);

  return (
    <>
      <Header />
      <GameHeader />
    </>
  );
};
export default Game;
