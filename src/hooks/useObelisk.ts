import { useEffect, useState } from 'react';
import { Obelisk, loadMetadata } from '@0xobelisk/client';
import { NETWORK, PACKAGE_ID } from '../chain/config';

const useObelisk = () => {
  const [obelisk, setObelisk] = useState<Obelisk>(null);

  useEffect(() => {
    const asyncHandler = async () => {
      const storageKey = localStorage.getItem('secretKey');
      const metadata = await loadMetadata(NETWORK, PACKAGE_ID);
      if (storageKey) {
        setObelisk(
          new Obelisk({
            networkType: NETWORK,
            packageId: PACKAGE_ID,
            metadata: metadata,
            secretKey: storageKey,
          }),
        );
      }
    };
    asyncHandler();
  }, [setObelisk]);
  return obelisk;
};

export default useObelisk;
