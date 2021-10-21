## Overview

These docs outline the deployment of cluster infrastructure, configuration of the base systems and deployment of HPC profiles on various platforms.

The process is:
- Perform 01_PLATFORM_TYPE.md steps (with the TYPE of choice) which detail:
    - Upload of Alces image to PLATFORM
    - Deployment of the Gateway node
- Perform 0[2-4]\_GATEWAY\_\*.md steps (with the platform & stack of choice) which detail: 
    - General Gateway configuration
    - Platform-specific Gateway configuration
    - Stack-specific Gateway configuration
- Perform 05_DEPLOY_TYPE.md steps which detail:
    - Deployment of Head, Infra, Compute & Admin nodes
- Perform 06_CONFIGURE_Base.md which details:
    - Base configuration & networking setup of Head, Infra, Compute & Admin nodes
- Perform 07_CONFIGURE_STACK.md steps (with the STACK of choice) which detail:
    - Configuring Queue system
    - Setting up shared storage
    - Preparing HPC environment

## Gateway Node

This node provides:
- Route to the Internet
- Deployment of other resources

## Infra Node

This node provides: 
- IPA (for DNS)

## Head Node

This node provides: 
- User login area
- Queue management
- Shared storage

## Admin Node

This node provides: 
- Root-privileged site access to data

## Compute Node

This node provides:
- Resources for job execution

