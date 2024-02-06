# import requests

# url = "https://api.pinata.cloud/users/apiKeys"

# payload={}
# headers = {
#   'pinata_api_key': 'd700bcd64283a55dae3c',
#   'pinata_secret_api_key': 'ada1c7e1e724a12ceb190f494aed03f688a4f24dac6eb40b3a10cddc83aded66'
# }

# response = requests.request("GET", url, headers=headers, data=payload)

# print(response.text)


# {"keys":[{"id":"3b86c48f-1ea8-4931-9c8c-10aeefb5c86a","name":"Alerto24",
# "key":"d700bcd64283a55dae3c",
# "secret":"371831ca827d3f1caba571f525f0810a:dea52795119e6b8554034d5c6a6aed7bea1723b62bc90ece3851ea57fd744b4afaf0be43242ff63d4c42078a953aa2f20b6db070d9b6d638e716dc650c8333ff","max_uses":null,"uses":0,"user_id":"f6b52605-c85b-4505-940c-4b0cc1565313","scopes":{"admin":true},"revoked":false,"createdAt":"2023-05-24T00:14:08.696Z","updatedAt":"2023-05-24T00:14:08.696Z"}],"count":1}

import requests

def upload():
    url = "https://api.pinata.cloud/pinning/pinFileToIPFS"

    payload={'pinataOptions': '{"cidVersion": 1}',
    'pinataMetadata': '{"name": "MyFile", "keyvalues": {"company": "Pinata"}}'}
    files=[
    ('file',('cat.JPG',open('/Users/datax/flutter/A-May-3/alerto24-AI/lib/Downloads/Pix.png','rb'),'application/octet-stream'))
    ]
    headers = {
    'pinata_api_key': 'd700bcd64283a55dae3c',
    'pinata_secret_api_key': 'ada1c7e1e724a12ceb190f494aed03f688a4f24dac6eb40b3a10cddc83aded66'
    }

    response = requests.request("POST", url, headers=headers, data=payload, files=files)

    print(response.text)


def query():
    url = "https://api.pinata.cloud/data/pinList?status=pinned&pinSizeMin=100"

    payload={}
    headers = {
    'pinata_api_key': 'd700bcd64283a55dae3c',
    'pinata_secret_api_key': 'ada1c7e1e724a12ceb190f494aed03f688a4f24dac6eb40b3a10cddc83aded66'
    }

    response = requests.request("GET", url, headers=headers, data=payload)

    print(response.text)

def usage():

    url = "https://api.pinata.cloud/data/userPinnedDataTotal"
    
    payload={}
    headers = {
    'pinata_api_key': 'd700bcd64283a55dae3c',
    'pinata_secret_api_key': 'ada1c7e1e724a12ceb190f494aed03f688a4f24dac6eb40b3a10cddc83aded66'
    }
    
    response = requests.request("GET", url, headers=headers, data=payload)
    
    print(response.text)

# upload()
# {"IpfsHash":"bafybeicfk3v5524h6664jxnytgw7l326smtsy5czde4hxfyzgs76y3yqfm",
# "PinSize":828721,
# "Timestamp":"2023-05-24T00:28:17.570Z"}

query()
# {"count":1,"rows":[{"id":"edc8c11d-ee24-41f9-838c-6d6a4f51490f",
# "ipfs_pin_hash":"bafybeicfk3v5524h6664jxnytgw7l326smtsy5czde4hxfyzgs76y3yqfm",
# "size":828721,"user_id":"f6b52605-c85b-4505-940c-4b0cc1565313",
# "date_pinned":"2023-05-24T00:28:17.570Z","date_unpinned":null,
# "metadata":{"name":"MyFile",
# "keyvalues":{"company":"Pinata"}},
# "regions":[{"regionId":"EU-CENTRAL-1",
# "currentReplicationCount":1,
# "desiredReplicationCount":1}]}]}

usage()
# {"pin_count":2,"pin_size_total":2272278,"pin_size_with_replications_total":2272278}