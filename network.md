# Network overview

Example diagram for a network setup at an OL-event.

```mermaid

flowchart LR
  linkStyle default stroke:#bfcddb,stroke-width:4px,color:#000
  classDef Large font-size:16pt;

    subgraph Internet [Internet Access]
      style Internet fill:#ff8400,color:#000,font-size:16pt
      direction TB
      M --- ISP{Internet Provider}
      ISP --- Int((Internet))
      classDef Iclass fill:#ff9639,stroke:#000,stroke-width:4px,color:#000,font-size:12pt;
      class M,ISP,Int Iclass;
      class Internet Large;
    end

    subgraph ER [Edge Router X\n]
      style ER fill:#6495ed,color:black

      subgraph Ports1 [Port Overview]
        style Ports1 fill:#7fa3f0,color:#000

        subgraph VLAN21 [VLAN1]
          style VLAN21 fill:#96b2f3,color:black
          PX1[Eth0]
          PX2[Eth1]
          PX3[Eth2]

        end

        subgraph VLAN22 [VLAN2]
          style VLAN22 fill:#96b2f3,color:black
          PX4[Eth3]
          PX5[Eth4]
        end
      end
      classDef Xclass fill:#acc1f6,stroke:#6495ed,stroke-width:4px,color:#000;
      class PX1,PX2,PX3,PX4,PX5 Xclass;
      class ER Large;
    end

    subgraph Switch
      style Switch fill:#00e5ff,color:#000
      direction TB
      P8
      P7
      P9  === PX1

      subgraph Ports2 [Port Overview]
        style Ports2 fill:#5be9ff,color:#000

        subgraph VLAN1
          style VLAN1 fill:#82edff,color:#000
          direction TB
          P1[Eth 0/1]
          P2[Eth 0/2]
          P3[Eth 0/3]
          P4[Eth 0/4]
          P5[Eth 0/5]
          P8[Eth 0/8]
          P9[GiE 1/1]
        end

        subgraph VLAN2
          style VLAN2 fill:#82edff,color:#000
          direction TB
          P6[Eth 0/6] === M[Modem 4G/5G]
          P7[Eth 0/7]  === PX5
        end
      end
      classDef Swclass fill:#a0f1ff,stroke:#00e5ff,stroke-width:4px,color:#000;
      class P1,P2,P3,P4,P5,P6,P7,P8,P9 Swclass;
      class Switch Large;
    end

      subgraph Wifi
        style Wifi fill:#f0e68c,color:#000
        C1(Computer) --- AP
        C2(Computer) --- AP
        C5(Computer) --- AP
        AP{AccessPoint} --- P8
        E1((Entry station)):::Wclass --- C1
        F1((Finish readout)):::Wclass --- C2
        SP1((Speaker)):::Wclass --- C5

      subgraph ServicesW [Services]
        style ServicesW fill:#f3e99d,color:black
        E1
        F1
        SP1
      end

      classDef Wclass fill:#f6edad,stroke:#f0e68c,stroke-width:4px,color:#000;
      class C1,C2,C5,AP Wclass;
      class Wifi Large;
    end

    subgraph Ethernet
      style Ethernet fill:#6495ed,color:#000
      C3(Computer) --- P1
      C4(Computer) --- P2
      B --- C3
      S1(Server) --- P3
      O --- S1
      L --- C4
      classDef Eclass fill:#96b2f3,stroke:#6495ed,stroke-width:4px,color:#000;
      class C3,C4,S1 Eclass;
      class Ethernet Large;

      subgraph ServicesE [Services]
          style ServicesE fill:#7fa3f0,color:black
          B(Unifi)
          O(OLA)
          L(Live resultat)
          classDef Sclass fill:#96b2f3,color:black;
          class B,O,L Sclass;
      end
    end


```
