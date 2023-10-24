import { ObeliskConfig } from '@0xobelisk/common';

export const obeliskConfig = {
  name: 'happyfarm',
  description: 'happyfarm',
  systems: ['counter_system', 'player_system', 'field_system', 'plant_system'],
  schemas: {
    global: {
      valueType: {
        counter: 'u64',
        admin: 'address',
        field_price: 'u64',
        last_field_no: 'u64',
        init_user_socre: 'u64',
        sun_score_need: 'u64',
        rain_score_need: 'u64',
        wind_score_need: 'u64',
        snow_score_need: 'u64',
      },
      defaultValue: {
        counter: 0,
        admin: '0xbd2ff4ec18e5263cedda158985da65fc5324f4df81632db8f0146a1f1e41b697',
        field_price: 50,
        last_field_no: 1000,
        init_user_socre: 800,
        sun_score_need: 15,
        rain_score_need: 10,
        wind_score_need: 25,
        snow_score_need: 16,
      },
    },
    player_info: {
      valueType: {
        score: 'u64',
        register: 'bool',
      },
    },
    field_info: {
      valueType: {
        owner: 'address',
        filed_no: 'u64',
        last_plant_no: 'u64',
      },
    },
    plant: {
      valueType: {
        score: 'u64',
        owner: 'address',
        plant_type: 'address',
        harvested: 'bool',
        plant_type_no: 'u64',
      },
    },
    plant_attrs: {
      valueType: {
        url: 'vector<u8>',
        init_score: 'u64',
        harvest_socre: 'u64',
        sun_effect: 'u64',
        wind_effct: 'u64',
        rain_effct: 'u64',
        snow_effct: 'u64',
      },
    },
  },
} as ObeliskConfig;
