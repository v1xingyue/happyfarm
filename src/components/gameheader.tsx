import { useAtom } from 'jotai';
import { PlayerInfo, PlayerInfoVersion, UserAddress, WorldVersion } from '../jotai';
import { TransactionBlock } from '@mysten/sui.js';
import { packageLink } from '../tool';
import { PACKAGE_ID, WORLD_ID } from '../chain/config';
import { useEffect } from 'react';
import useObelisk from '../hooks/useObelisk';

const GameHeader = () => {
  const [playerInfo, setPlayerInfo] = useAtom(PlayerInfo);
  const [playerInfoVersion, setPlayerInfoVersion] = useAtom(PlayerInfoVersion);
  const [address] = useAtom(UserAddress);
  const [worldVersion, setWorldVersion] = useAtom(WorldVersion);

  const obelisk = useObelisk(localStorage.getItem(''));

  const registerGame = async () => {
    if (obelisk == null) return;
    const tx = new TransactionBlock();
    const world = tx.pure(WORLD_ID);
    const params = [world];
    const new_tx = await obelisk.tx.player_system.register(tx, params, true);
    const response = await obelisk.signAndSendTxn(new_tx as TransactionBlock);
    if (response.effects.status.status == 'success') {
      setPlayerInfoVersion(playerInfoVersion + 1);
    }
  };

  const buyAField = async () => {
    if (obelisk == null) return;
    const tx = new TransactionBlock();
    const world = tx.pure(WORLD_ID);
    const params = [world];
    const new_tx = await obelisk.tx.field_system.buy_a_field(tx, params, true);
    const response = await obelisk.signAndSendTxn(new_tx as TransactionBlock);
    if (response.effects.status.status == 'success') {
      setPlayerInfoVersion(playerInfoVersion + 1);
      setWorldVersion(worldVersion + 1);
    }
  };

  useEffect(() => {
    const fetchPlayerInfo = async () => {
      if (address == '' || obelisk == null) return;
      const result = await obelisk.getEntity(WORLD_ID, 'player_info', address);
      if (result) {
        const [score, register] = result;
        setPlayerInfo({
          score,
          register,
          refresh: 0,
        });
      }
    };
    fetchPlayerInfo();
  }, [address, setPlayerInfo, playerInfoVersion]);

  return (
    <div className="mt-2">
      <div>
        World Links:{' '}
        <a className="link link-hover link-info" target="_blank" href={packageLink(PACKAGE_ID)}>
          {PACKAGE_ID}
        </a>
      </div>
      <div className="mt-3">
        {playerInfo.register ? (
          <p>
            <span className="ml-3">Score: {playerInfo.score}</span>
            <button onClick={buyAField} className="btn btn-primary ml-5">
              Buy a field
            </button>
          </p>
        ) : (
          <button className="btn btn-info" onClick={registerGame}>
            Register Game
          </button>
        )}
      </div>
    </div>
  );
};

export default GameHeader;
