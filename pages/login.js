import React, { useEffect } from 'react';

import {Elm} from './../src/Login/Main.elm'
import Head from 'next/head'

export default function Home() {
  
  useEffect(() => {
    
    Elm.Login.Main.init({
        flags: {},
        node: document.getElementById('app')
    })

    return () => null;

  }, []);

  return (
    <div className="container">
      <Head>
        <title>Create Next App</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main>
          <h1>Homepage</h1>
          <div id="app"/>
      </main>
      
    </div>
  )
}
