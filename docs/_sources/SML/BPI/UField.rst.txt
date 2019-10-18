UField
======
A `UField`_ is a `UObject <UObject>`_ mainly containing a attribute ``next`` pointing to the next `UField`_ instance.

Next
----
The next attribute points to the next `UField`_ in a row. Each `UField`_ points to the next one until it reaches nullptr.
This creates a chain of `UFields`.