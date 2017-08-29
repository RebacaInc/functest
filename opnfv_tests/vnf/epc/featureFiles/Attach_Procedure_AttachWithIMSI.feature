############################################################################################################################
#                                              Date: <22/08/2016> Version: <1.1>                                           #
############################################################################################################################

Feature:Attach_Procedure_AttachWithIMSI

  @attach-procedure @Attach_Procedure_AttachWithIMSI @TS_24_301 @24_301_5_5 @24_301_5_5_1_2_2 @TS_24_368 @24_368_4 @24_368-5_4 @Series-0000
    
  Scenario: Attach Procedure Success configured with AttachWithIMSI when Selected PLMN is neither the registered PLMN nor in the list of equivalent PLMNs
  
    Given all configured endpoints for SSH are connected successfully
    
    Given the steps below will be executed at the end
    When I stop S1AP simulator on node ABOT
    When I run the SSH command "sudo service mme_gw restart" on node MME
    Given the execution is paused for {Config.WAIT_10_SEC} seconds
    Then the ending steps are complete
	
        # Set ABOT configuration
        Given that I setup S1AP Simulator with default parameters specified in {Config.ABOT.EPC.Defaults} on node ABOT
        Given that I setup S1AP Simulator with USIM parameter "ABOT.UE.USIM.AttachWithImsi=true" on node ABOT
    
        # Execute ABOT S1AP Simulator
        When I run S1AP simulator on node ABOT

        # Wait for execution to complete before checking results
        Given the execution is paused for {Config.WAIT_10_SEC} seconds

        # Validate Test Case Execution at Simulator
        Then I receive S1AP response on node ABOT and verify the presence of all the following values:
        | string                                             | occurrence |
        | Send Attach Request message with IMSI              | PRESENT    |
        | Received Authentication Request message            | PRESENT    |
        | Send Authentication Response message               | PRESENT    |
        | Received Authentication Request message            | PRESENT    |
        | Send Authentication Response message               | PRESENT    |
        | Received Security Mode Command message             | PRESENT    |
        | Send Security Mode Complete message                | PRESENT    |
        | Received Attach Accept message                     | PRESENT    |