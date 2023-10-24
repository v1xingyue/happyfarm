import { SuiTransaction, SuiTransactionBlockResponse, TransactionBlock } from '@mysten/sui.js';
import { LoadObelisk } from '../src/tool';
import { WORLD_ID } from '../src/chain/config';

async function main() {
  const obelisk = await LoadObelisk();
  console.log(obelisk.currentAddress());

  for (let idx = 15; idx < 20; idx++) {
    let tx = new TransactionBlock();

    let plant_id = await obelisk.entity_key_from_u256(idx);
    let params = [
      tx.pure(WORLD_ID),
      tx.pure(plant_id),
      tx.pure('https://img0.baidu.com/it/u=1991033559,2195249320&fm=253&fmt=auto&app=138&f=PNG?w=500&h=500'),
      tx.pure(30),
      tx.pure(100),
    ];

    for (let m = 0; m < 4; m++) {
      let value = Math.floor(Math.random() * 5);
      params.push(tx.pure(value));
    }

    const result = (await obelisk.tx.plant_system.make_plant(tx, params)) as SuiTransactionBlockResponse;
    console.log(result);
  }
}

export default main();