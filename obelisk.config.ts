import { ObeliskConfig } from '@0xobelisk/common';

export const obeliskConfig = {
  name: 'happyfarm',
  description: 'happyfarm',
  systems: ['counter_system', 'player_system', 'field_system'],
  schemas: {
    global: {
      valueType: {
        counter: 'u64',
        admin: 'address',
        field_price: 'u64',
        last_field_no: 'u64',
        init_user_socre: 'u64',
      },
      defaultValue: {
        counter: 0,
        admin: '0x0000000',
        field_price: 10,
        last_field_no: 1000,
        init_user_socre: 200,
      },
    },
    player_info: {
      valueType: {
        score: 'u64',
        field: 'u64',
        register: 'bool',
      },
    },
    plant: {
      valueType: {
        pos: 'vector<u8>',
        score: 'u64',
        owner: 'address',
        plant_type: 'u64',
      },
    },
    plant_attrs: {
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
