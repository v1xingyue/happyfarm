import { Obelisk, loadMetadata } from '@0xobelisk/client';
import { NETWORK, PACKAGE_ID } from '../chain/config';
import { PRIVATEKEY } from '../chain/key';

const LoadObelisk = async () => {
  const metadata = await loadMetadata(NETWORK, PACKAGE_ID);
  let storageKey = null;
  if (typeof window !== 'undefined' && window.localStorage) {
    storageKey = localStorage.getItem('secretKey');
  }

  if (storageKey) {
    return new Obelisk({
      networkType: NETWORK,
      packageId: PACKAGE_ID,
      metadata: metadata,
      secretKey: storageKey,
    });
  } else {
    return new Obelisk({
      networkType: NETWORK,
      packageId: PACKAGE_ID,
      metadata: metadata,
      secretKey: PRIVATEKEY,
    });
  }
};

const linkName = () => {
  if (NETWORK === 'localnet') {
    return 'local';
  } else {
    return NETWORK;
  }
};

const addressLink = (addr: string) => {
  return `https://suiexplorer.com/address/${addr}?network=${linkName()}`;
};

const objectLink = (addr: string) => {
  return `https://suiexplorer.com/object/${addr}?network=${linkName()}`;
};

const packageLink = (addr: string) => {
  return `https://suiexplorer.com/object/${addr}?network=${linkName()}`;
};

export { LoadObelisk, addressLink, objectLink, packageLink };
