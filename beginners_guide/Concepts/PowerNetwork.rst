Power-Network
=============
We currently don't realy know how the power network works, but we do know how we can use it, and in this chapter we explain it for you.

The Power-Network consists of three key components.

- UFGPowerCircuit
    This class manages a power networks (aka. PowerCircuit) itself. It gathers data about the current production and consumption of the network and decides what needs to happen.
- UFGPowerConnectionComponent
    This is the component used to connect components/machines together. It manages cable connections and hidden connections from other connection components to itself.
    It f.e. limits the amount of cables you can attach to it.
- UFGPowerInfoComponent
    This component representates the needs of a power consumer/producer itself (like production, consumption).
    If you f.e. want to know if your machine has power, you will need to use this component.

FGPowerConnectionComponent
--------------------------
This class manages is a connection point for wires and hidden connections to "transfer" energy.

FGPowerInfoComponent
--------------------
This class handles and contains information about the needs and status of a power consumer/producer.

