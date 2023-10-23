import { atom } from 'jotai';

const Value = atom('');
const UserAddress = atom('');
const UserBalance = atom('');
const PlayerInfo = atom({
  score: 0,
  field: 0,
  register: false,
  refresh: 0,
});

const PlayerInfoVersion = atom(0);
const BalanceVersion = atom(0);
const SecretKey = atom('');

const FieldAddrs = atom([]);

export { Value, UserAddress, UserBalance, PlayerInfo, PlayerInfoVersion, SecretKey, BalanceVersion, FieldAddrs };
