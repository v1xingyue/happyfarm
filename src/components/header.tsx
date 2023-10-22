import { useAtom } from 'jotai';
import { BalanceVersion, UserAddress, UserBalance } from '../jotai';
import { LoadObelisk } from '../tool';
import { NETWORK } from '../chain/config';
import { FaucetNetworkType } from '@0xobelisk/client';

const Header = () => {
  const [balanceVersion, setBalanceVersion] = useAtom(BalanceVersion);
  const [address] = useAtom(UserAddress);
  const [blance] = useAtom(UserBalance);

  const doAirDrop = async () => {
    if (address) {
      const obelisk = await LoadObelisk();
      await obelisk.requestFaucet(address, NETWORK as FaucetNetworkType);
      setBalanceVersion(balanceVersion + 1);
    }
  };

  return (
    <div>
      <span>Address : {address}</span>
      <span className="ml-3">Balance: {blance}</span>
      {blance == '0' ? (
        <button onClick={doAirDrop} className="btn btn-info ml-2">
          airdrop{' '}
        </button>
      ) : null}
    </div>
  );
};

export default Header;
