############################################################################################################################
#                                              Date: <22/08/2016> Version: <1.1>                                           #
############################################################################################################################

Feature:  Attach Procedure With IM CN Subsystem Signalling Flag Indication in PCO

  @attach-procedure @TS_24_301 @24_301_5_5 @24_301_5_5_1_2_2 @TS_24_368 @24_368_4 @24_368-5_4 @Series-0000
  @TS_36_523_9_2_1_1_3 @Attach_Procedure_IM_CN_Subsystem_Signalling_Flag @PCO 
    
  Scenario: Attach Procedure indicating IM CN Subsystem Signalling Flag in the protocol configuration options
  
    Given all configured endpoints for SSH are connected successfully
    
    Given the steps below will be executed at the end
    When I stop S1AP simulator on node ABOT
    When I run the SSH command "sudo service mme_gw restart" on node MME
    Given the execution is paused for {Config.WAIT_10_SEC} seconds
    Then the ending steps are complete
	
        # Set ABOT configuration
        Given that I setup S1AP Simulator with default parameters specified in {Config.ABOT.EPC.Defaults} on node ABOT
        Given that I setup S1AP Simulator with USIM parameter "ABOT.UE.USIM.AttachWithImsi=true" on node ABOT

        Given that I setup S1AP Simulator with UE parameter "ABOT.UE.CONFIG.PCO.IM_CN_SS_SIGNAL_FLAG=true" on node ABOT
 
        # Execute ABOT S1AP Simulator
        When I run S1AP simulator on node ABOT

        # Wait for execution to complete before checking results
        Given the execution is paused for {Config.WAIT_10_SEC} seconds

        # Validate Test Case Execution at Simulator
        Then I receive S1AP response on node ABOT and verify the presence of all the following values:
        | string                                             | occurrence |
        | Send Attach Request message with IMSI              | PRESENT    |
        | Send PDN Connectivity Request message with IM CN Subsystem Signalling Flag | PRESENT |
        | Received Authentication Request message            | PRESENT    |
        | Send Authentication Response message               | PRESENT    |
        | Received Authentication Request message            | PRESENT    |
        | Send Authentication Response message               | PRESENT    |
        | Received Security Mode Command message             | PRESENT    |
        | Send Security Mode Complete message                | PRESENT    |
        | Received Attach Accept message                     | PRESENT    |
        | Received Activate Default EPS Bearer Context Request message with PCO contain Protocol ID 0002 | PRESENT |