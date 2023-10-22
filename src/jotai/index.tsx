import { atom } from 'jotai';

const Value = atom('');
const UserAddress = atom('');
const UserBalance = atom('');
const PlayerInfo = atom({
  score: 0,
  room: '@0x0',
  register: false,
  refresh: 0,
});

const PlayerInfoVersion = atom(0);

export { Value, UserAddress, UserBalance, PlayerInfo, PlayerInfoVersion };
