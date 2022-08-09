from kiot.client.vimar_kiot_client import VimarKiotClient
from kiot.endpoints.kiot_authentication import KiotAuthentication, KiotAuthenticationType

#   DRSE Hackathon credentials
AUTH_TOKEN = "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJuR0lIV085Z1VoMVVJeWs4eHA2ZE5sNGUtTnRuZVBBdnRKRnhKaUtRRGFZIn0.eyJleHAiOjE2NjU5MzIyOTcsImlhdCI6MTY1OTQ1MjI5NywiYXV0aF90aW1lIjoxNjU5NDQ5ODYyLCJqdGkiOiI5ZmNkMmIzYS02NTQxLTRiY2UtOGRiZC1kOWI3MTYwMGIxYzYiLCJpc3MiOiJodHRwczovL3ByZXByb2QzLnZpbWFyLmNsb3VkL2F1dGgvcmVhbG1zL3ZpbWFydXNlciIsImF1ZCI6ImFjY291bnQiLCJzdWIiOiI0NDhjNWY1OC00Y2UzLTRmMjItOTE4Yy1iNGRiNjQ5ZDg0NGUiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJoYWNrYXRob25fY2xpZW50X2Jhc2ljIiwic2Vzc2lvbl9zdGF0ZSI6ImJmNjJmOWYwLWNhNDUtNGNmNC1iYWViLWQ1NGQxNjBlMGNhYyIsImFjciI6IjAiLCJhbGxvd2VkLW9yaWdpbnMiOlsiaHR0cHM6Ly9wcmVwcm9kMy52aW1hci5jbG91ZC8iLCJodHRwOi8vaG9zbWFydGFpMS5wcmVwcm9kMy52aW1hci5jbG91ZC5pbnRlcm5hbDo4MDgwIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJvZmZsaW5lX2FjY2VzcyIsInVzZXIiXX0sInJlc291cmNlX2FjY2VzcyI6eyJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6ImtueF9jb25zdW1wdGlvbl9jb250cm9sIGtueF9zaHV0dGVyX2NvbnRyb2wga254X3NjZW5lX3BlcnNvbmFsaXplIGtueF9sb2FkX2NvbnRyb2wga254X2FjY2Vzc19jb250cm9sIHdyaXRlIGtueF9zZW5zb3JfY29udHJvbCBrbnhfZW5lcmd5X3BlcnNvbmFsaXplIGtueF9jbGltYXRlX2NvbnRyb2wgbWFuYWdlIGtueF9zY2VuZV9jb250cm9sIG9mZmxpbmVfYWNjZXNzIGtueF9hY3R1YXRvcl9jb250cm9sIGtueF9saWdodF9jb250cm9sIGtueF9jbGltYXRlX3BlcnNvbmFsaXplIHJlYWQifQ.OtRKRqHdoVgGtPqwESHIaYQ5jtyyxtSx9GfT1Qw_1gtKJdddEd9ymqyhS1WGgtH2fQEgRvLVCcBvzr2H6YM9UEejItwKDKFGdrljojZYAcGJR6n7rJ-6NCNDGnKUlGrlwzfFZ_6UEVydntTLFMkMuuz2RcGyPMMHM63pYS8iAt2kHnij2bHCgDs55aFoMxHvxgvcHYD73ymT2d-BAm9JAnTPmeCg6YJioyb6uhZEGsmAOoHOzSMrG4NawvMChKPA8rP6vPKKQPqoYjzGk04I-B3SpokhlS1W2TCaoulYV3741n2f3VBpBOjyuytptHJ6y8SSZOX49LymFPqmhB17GQ"
KNX_PLANT_ID = "c5759b62-2d20-43b4-93f2-fa7e7475711a"
KNX_URL = "https://knx-preprod3.vimar.cloud/api/v2"

auth_handler = KiotAuthentication(KiotAuthenticationType.BEARER, auth_bearer_token=AUTH_TOKEN)
client = VimarKiotClient(auth_handler, KNX_URL, KNX_PLANT_ID)

bContinue = True
while (bContinue):
    result, lightswitches = client.get_available_lightswitches() # List of VimarSsLightSwitch
    if not result:
        print("Unable to get lights!")
        exit()

    for light in lightswitches:
        print(f"> Light '{light.title}' is {light.onoff}") # Get a SFE_State_OnOff
    new_key = int(input("What light do you want to change? [0,1,2,...]]"))
    new_value = input(f"What value do you want to set to '{lightswitches[new_key].title}' [On/Off]? ")
    res, msg = lightswitches[new_key].cmd_onoff(new_value) # Send a SFE_Cmd_OnOff
    #res, msg = light.cmd_onoff(new_value) # Send a SFE_Cmd_OnOff
    print(msg)
    bContinue = input("Whanna change onother one? [Y/N]")
