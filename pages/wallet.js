import { Web3Button, Web3Modal, Web3NetworkSwitch } from '@web3modal/react'
import { ethereumClient, projectId } from './_app'


const Wallet = () => {
    return (
        <>
            <h2>Buttons</h2>
            <div className="container">
                {/* Use predefined button  */}
                <Web3Button icon="show" label="Connect Wallet" balance="show" />

                <Web3NetworkSwitch />
            </div>

            <Web3Modal projectId={projectId} ethereumClient={ethereumClient} />
        </>
    )
}

export default Wallet;