Feature: Local_Commands_Testing

  @local-commands
  Scenario: Local Commands testing
    Given all configured endpoints for SSH are connected successfully
    When I execute the command ifconfig in this system and check the presence of following strings in the response:
      | string | occurrence |
      | inet | PRESENT |
      | UP | PRESENT |
      | BROADCAST | PRESENT |
      | RUNNING | PRESENT |
      | MULTICAST | PRESENT |
