import React, { useEffect } from 'react';

import {Elm} from './../src/Login/Main.elm'
import Head from 'next/head'
import { useRouter } from 'next/router';

export default function Home() {
  const router = useRouter()
  let elmApp;
  
  useEffect(() => {
    
    elmApp = Elm.Login.Main.init({
        flags: {},
        node: document.getElementById('app')
    })

    elmApp.ports.urlChanged.subscribe(url => {
      console.log('Moving to url', url)
      router.push(url, undefined, { shallow: true })
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

export const getStaticProps = async () => {
  return {
    props: {}
  }
}

export const getStaticPaths = async () => {
  return {
    paths: ['/login', '/login/logged'],
    fallback: false,
  }
}
