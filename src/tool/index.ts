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

const addressLink = (addr: string) => {
  const linkName = NETWORK.substring(0, NETWORK.length - 3);
  return `https://suiexplorer.com/address/${addr}?network=${linkName}`;
};

const objectLink = (addr: string) => {
  const linkName = NETWORK.substring(0, NETWORK.length - 3);
  return `https://suiexplorer.com/object/${addr}?network=${linkName}`;
};

const packageLink = (addr: string) => {
  const linkName = NETWORK.substring(0, NETWORK.length - 3);
  return `https://suiexplorer.com/object/${addr}?network=${linkName}`;
};

export { LoadObelisk, addressLink, objectLink, packageLink };
