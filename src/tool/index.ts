import { Obelisk, loadMetadata } from '@0xobelisk/client';
import { NETWORK, PACKAGE_ID } from '../chain/config';
import { PRIVATEKEY } from '../chain/key';

const LoadObelisk = async () => {
  const metadata = await loadMetadata(NETWORK, PACKAGE_ID);
  const storageKey = localStorage.getItem('secretKey');
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

export { LoadObelisk };
