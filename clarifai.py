# Clarifai

from clarifai_grpc.channel.clarifai_channel import ClarifaiChannel
from clarifai_grpc.grpc.api import resources_pb2, service_pb2, service_pb2_grpc
from clarifai_grpc.grpc.api.status import status_pb2, status_code_pb2

import pandas as pd

# Clarifai Python gRPC Client
def clarifai_demographics(path_to_jpg, api_key):

    channel = ClarifaiChannel.get_json_channel()
    stub = service_pb2_grpc.V2Stub(channel)
    metadata = (('authorization', 'Key ' + api_key),)

    with open(path_to_jpg, 'rb') as f:
        file_bytes = f.read()

    post_model_outputs_response = stub.PostModelOutputs(
        service_pb2.PostModelOutputsRequest(
            # demographics model
            model_id= 'c0c0ac362b03416da06ab3fa36fb58e3',
            inputs=[
                resources_pb2.Input(
                    data=resources_pb2.Data(
                        image=resources_pb2.Image(
                            base64=file_bytes
                        )
                    )
                )
            ]
        ),
        metadata=metadata
    )

    if post_model_outputs_response.status.code != status_code_pb2.SUCCESS:
        raise Exception(post_model_outputs_response.status.description)

    output = post_model_outputs_response.outputs[0]
        
    return output
    
    
def d_list_to_df(d_list):
    
    df = pd.DataFrame(d_list)
    
    return df
