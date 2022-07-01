import '@pyxis/scss';

import React, { useEffect } from 'react';

import { useRouter } from 'next/router';

const FrontaleApp = ({ Component, pageProps }) => {
  const router = useRouter();
  
  return (
    <>
      <div style={ {maxWidth: '800px', margin: '0 auto'}}>
        <Component {...pageProps} /> 
      </div>
    </>
  );
};

export default FrontaleApp;