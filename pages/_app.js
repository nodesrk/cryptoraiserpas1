import { EthereumClient, modalConnectors, walletConnectProvider } from '@web3modal/ethereum'
import { configureChains, createClient, WagmiConfig } from 'wagmi'
import { arbitrum, avalanche, bsc, fantom, mainnet, optimism, polygon } from 'wagmi/chains'
import { useEffect, useState } from 'react'

import Layout from '../components/layout/Layout';
import '../style/global.css'


if (!process.env.NEXT_PUBLIC_PROJECT_ID) {
  throw new Error('You need to provide NEXT_PUBLIC_PROJECT_ID env variable')
}

export const projectId = process.env.NEXT_PUBLIC_PROJECT_ID

// 2. Configure wagmi client
const chains = [mainnet, polygon, optimism, arbitrum, avalanche, fantom, bsc]
const { provider } = configureChains(chains, [walletConnectProvider({ projectId })])
export const wagmiClient = createClient({
  autoConnect: true,
  connectors: modalConnectors({ appName: 'web3Modal', chains }),
  provider
})

// 3. Configure modal ethereum client
export const ethereumClient = new EthereumClient(wagmiClient, chains)


function MyApp({ Component, pageProps }) {

  const [ ready,setReady ] = useState(false)

  useEffect(() => {
    setReady(true)
  }, [])

  return (
    <>
      {ready ? (
        <WagmiConfig client={wagmiClient}>
          <Layout>
            <Component {...pageProps} />
          </Layout>
        </WagmiConfig>
      ) : null}
    </>
  )
}

export default MyApp
