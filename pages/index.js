import Head from 'next/head'
import React from 'react';
import { useRouter } from 'next/router';

export default function Home() {
  const router = useRouter()

  return (
    <div className="container">
      <Head>
        <title>Create Next App</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>
 
      <main>
          <h1>Homepage</h1>
          <p>This template is handled by React.</p>
          <br/><br/>
          <p>
            You can see a working example of <code className="c-brand-base padding-4xs">Browser.document</code> Elm form application 
            <br/>
            <button 
              className="button button--primary button--medium" 
              onClick={() => router.push('/form')}>Do a quotation
            </button>
          </p>
          <br/>
          <br/>
          <p>
            Or maybe a <code className="c-brand-base padding-4xs">Browser.application</code> Elm SPA
            <br/>
            <button 
              className="button button--primary button--medium" 
              onClick={() => router.push('/login')}>Login
            </button>
          </p>
      </main>
      
    </div>
  )
}
