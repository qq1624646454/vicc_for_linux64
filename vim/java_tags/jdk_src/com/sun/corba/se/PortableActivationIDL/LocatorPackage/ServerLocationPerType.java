package com.sun.corba.se.PortableActivationIDL.LocatorPackage;


/**
* com/sun/corba/se/PortableActivationIDL/LocatorPackage/ServerLocationPerType.java .
* Generated by the IDL-to-Java compiler (portable), version "3.2"
* from /HUDSON3/workspace/8-2-build-linux-amd64/jdk8u101/7261/corba/src/share/classes/com/sun/corba/se/PortableActivationIDL/activation.idl
* Wednesday, June 22, 2016 3:00:37 AM PDT
*/

public final class ServerLocationPerType implements org.omg.CORBA.portable.IDLEntity
{
  public String hostname = null;
  public com.sun.corba.se.PortableActivationIDL.ORBPortInfo ports[] = null;

  public ServerLocationPerType ()
  {
  } // ctor

  public ServerLocationPerType (String _hostname, com.sun.corba.se.PortableActivationIDL.ORBPortInfo[] _ports)
  {
    hostname = _hostname;
    ports = _ports;
  } // ctor

} // class ServerLocationPerType
