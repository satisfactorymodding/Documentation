Power-Network
=============
We currently don't really know how the power network works, but we do know how we can use it, and in this chapter, we explain it to you.

The Power-Network consists of three key components.

- UFGPowerCircuit
    This class manages a power network (aka. PowerCircuit) itself. It gathers data about the current production and consumption of the network and decides what needs to happen.
- UFGPowerConnectionComponent
    This is the component used to connect components/machines. It manages cable connections and hidden connections from other connection components to itself.
    It f.e. limits the number of cables you can attach to it.
- UFGPowerInfoComponent
    This component represents the needs of a power consumer/producer itself (like production, consumption).
    If you f.e. want to know if your machine has power, you will need to use this component.

FGPowerConnectionComponent
--------------------------
This class manages is a connection point for wires and hidden connections to "transfer" energy.

- M Max Num Connection Links
    Max number of connections allowed to get connected to the connections
- M Is Hidden Connection
    If the connections should be hidden (no cables allowed)
- M Wires
    The list of connected wires (cables)
- M Nb Wires connected
    Number od wires connected to this component
- M Circuit ID
    The ID of the connected power circuit
- M Hidden Connections
    The list of hidden connections (train rails)

FGPowerInfoComponent
--------------------
This class handles and contains information about the needs and status of a power consumer/producer.

You need to use the provided member functions (nodes) to set/get data like:

- Target consumption
    The amount of power the power consumer needs to work
- Base Production
    The amount of power the producer produces definitely (like a geothermal generator) and doesn't get decreased dynamically like a fuel generator.
- Dynamic Production Capacity
    The max amount of power the producer can provide. (used to limit the dynamic production)
- Actual Consumption
    The consumption used in the last tick of the power grid.
- Regulated Dynamic Production
    The amount of power provided to the power circuit in the last tick.
- Has Power
    If the consumer has actual power
