# Clarifai

from clarifai_grpc.channel.clarifai_channel import ClarifaiChannel
from clarifai_grpc.grpc.api import resources_pb2, service_pb2, service_pb2_grpc
from clarifai_grpc.grpc.api.status import status_pb2, status_code_pb2

import pandas as pd

# Clarifai Python gRPC client
def clarifai_demographics(path_to_jpg, api_key, model_name):

    channel = ClarifaiChannel.get_json_channel()
    stub = service_pb2_grpc.V2Stub(channel)
    metadata = (('authorization', 'Key ' + api_key),)

    with open(path_to_jpg, 'rb') as f:
        file_bytes = f.read()

    post_workflow_results_response = stub.PostWorkflowResults(
        service_pb2.PostWorkflowResultsRequest(
            # demographics model
            workflow_id= 'Demographics',
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

    if post_workflow_results_response.status.code != status_code_pb2.SUCCESS:
        raise Exception("Post workflow results failed, status: " + post_workflow_results_response.status.description)

    results = post_workflow_results_response.results[0]
    
    for output in results.outputs:
        model = output.model
        if model.name == model_name: # 'multicultural-appearance' / 'gender-appearance'
            output_to_return = output

    return output_to_return
    
    
# make df from list of dictionaries    
def d_list_to_df(d_list):
    
    df = pd.DataFrame(d_list)
    
    return df