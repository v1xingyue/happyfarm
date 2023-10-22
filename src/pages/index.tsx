import type { NextPage } from 'next';
import Game from './game';
import { useAtom } from 'jotai';
import { SecretKey } from '../jotai';
import { useEffect, useState } from 'react';
import { Ed25519Keypair } from '@mysten/sui.js/keypairs/ed25519';

const IndexPage: NextPage = () => {
  const [secretKey, setSecretKey] = useAtom(SecretKey);
  const [value, setValue] = useState('');

  const saveSecretKey = () => {
    setSecretKey(value);
    localStorage.setItem('secretKey', value);
  };

  const createNewKey = () => {
    const keypair = new Ed25519Keypair();
    setValue(keypair.toSuiAddress().toString());
  };
  useEffect(() => {
    const secretKey = localStorage.getItem('secretKey');
    if (secretKey) {
      setSecretKey(secretKey);
    }
  }, [setSecretKey]);

  return (
    <main>
      {secretKey == '' ? (
        <div className="form-control w-full max-w-2xl">
          <label className="label">
            <span className="label-text">Input your secret key : </span>
          </label>

          <div className="input-group">
            <input
              type="text"
              value={value}
              onChange={e => {
                setValue(e.target.value);
              }}
              placeholder="input your secret key"
              className="input input-bordered w-full"
            />
            <button onClick={createNewKey} className="btn btn-info">
              Create New
            </button>
          </div>

          <button onClick={saveSecretKey} className="btn btn-warning mt-3">
            Save And Running
          </button>
        </div>
      ) : (
        <Game />
      )}
    </main>
  );
};

export default IndexPage;
