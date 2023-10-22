import { useAtom } from 'jotai';
import { PlayerInfo, PlayerInfoVersion, UserAddress, UserBalance } from '../jotai';
import { TransactionBlock } from '@mysten/sui.js';
import { LoadObelisk } from '../tool';
import { WORLD_ID } from '../chain/config';
import { useEffect } from 'react';

const Header = () => {
  const [playerInfo, setPlayerInfo] = useAtom(PlayerInfo);
  const [playerInfoVersion, setPlayerInfoVersion] = useAtom(PlayerInfoVersion);
  const [address] = useAtom(UserAddress);
  const [blance] = useAtom(UserBalance);
  const registerGame = async () => {
    const obelisk = await LoadObelisk();
    const tx = new TransactionBlock();
    const world = tx.pure(WORLD_ID);
    const params = [world];
    const new_tx = await obelisk.tx.player_system.register(tx, params, true);
    console.log(new_tx);
    const response = await obelisk.signAndSendTxn(new_tx as TransactionBlock);
    if (response.effects.status.status == 'success') {
      console.log('update player info');
      setPlayerInfoVersion(playerInfoVersion + 1);
    }
  };

  useEffect(() => {
    const fetchPlayerInfo = async () => {
      if (address == '') return;
      const obelisk = await LoadObelisk();
      const result = await obelisk.getEntity(WORLD_ID, 'player_info', address);
      if (result) {
        const [score, room, register] = result;
        console.log(score, room, register);
        setPlayerInfo({
          score,
          room,
          register,
          refresh: 0,
        });
      }
    };
    fetchPlayerInfo();
  }, [address, setPlayerInfo, playerInfoVersion]);

  return (
    <>
      <p>
        <span>{address}</span>
        <span className="ml-3">{blance}</span>
      </p>
      <p>
        {playerInfo.register ? (
          <span className="ml-3">{JSON.stringify(playerInfo)}</span>
        ) : (
          <span className="ml-3" onClick={registerGame}>
            <button className="btn btn-info">Register Game</button>
          </span>
        )}
      </p>
    </>
  );
};

export default Header;
