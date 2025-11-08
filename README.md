# EtherNetIP_ROP_Attack_OpenPLC

## Exploiting EtherNet/IP Protocol Passer Vulnerability [CVE-2024-34026](https://nvd.nist.gov/vuln/detail/cve-2024-34026)  and ROP Attack on OpenPLC

- First video [Debugging OpenPLC Binary and Finding Memory Addresses of the I/O Coils or Holding Registers Along With the Required Address of `pump1_start` for ROP Attack](https://www.youtube.com/watch?v=RoLePUb-xaM) illustrates the following steps:

1. Start debugging the OpenPLC binary using the `pwndbg` tool.
2. Find all the functions in the OpenPLC binary.
3. Set a breakpoint at the entry of the Control Logic Program function.
4. Run the OpenPLC binary.
5. Execute step-by-step.
6. In consecutive steps, we can observe multiple memory addresses mapped to different I/O coils/holding registers. The current value of `%QX0.0/pump1_start` is **True (1)**, and the address of `pump1_start` is stored in register `RAX`.
7. The identified address of `pump1_start` will be used in the ROP payload, and we will toggle the value from **True (1)** to **False (0)** to shut down pump1 through the ROP attack.

- Second video [ROP Attack on OpenPLC](https://www.youtube.com/watch?v=AMu2IQpb7VU) step-by-step demonstrates how overflow overwrites the saved return address and execution is redirected into our ROP chain, eventually performing the write of **True (1)** to the memory location pointed to by `RAX`, which changes the `pump1_start` coil's state and stops the pump. At the end, it restores the original stack frame and returns execution to the EtherNet/IP connection handler so that the OpenPLC continues its normal scan cycle without causing a crash or triggering watchdogs.


