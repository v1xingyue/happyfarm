import { ObeliskConfig } from '@0xobelisk/common';

export const obeliskConfig = {
  name: 'happyfarm',
  description: 'happyfarm',
  systems: ['counter_system', 'player_system'],
  schemas: {
    counter: {
      singleton: true,
      valueType: {
        counter: 'u64',
        admin: 'address',
      },
      defaultValue: {
        counter: 0,
        admin: '@0x0000000',
      },
    },
    player_info: {
      singleton: false,
      valueType: {
        score: 'u64',
        room: 'address',
        register: 'bool',
      },
    },
    room_info: {
      singleton: false,
      valueType: {
        pos: 'vector<u64>',
        size: 'u8',
      },
    },
    plant: {
      singleton: false,
      valueType: {
        pos: 'vector<u8>',
        score: 'u64',
        owner: 'address',
        plant_type: 'u64',
      },
    },
    plant_attrs: {
      singleton: false,
      valueType: {
        init_score: 'u64',
        sun_effect: 'u64',
        wind_effct: 'u64',
        rain_effct: 'u64',
        snow_effct: 'u64',
      },
    },
  },
} as ObeliskConfig;
