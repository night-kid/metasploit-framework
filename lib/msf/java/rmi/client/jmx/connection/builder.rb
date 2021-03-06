# -*- coding: binary -*-

module Msf
  module Java
    module Rmi
      module Client
        module Jmx
          module Connection
            module Builder
              # Builds an RMI call to javax/management/remote/rmi/RMIConnectionImpl_Stub#getObjectInstance()
              # used to retrieve an MBean instance
              #
              # @param opts [Hash]
              # @option opts [String] :name the MBean name
              # @return [Rex::Proto::Rmi::Model::Call]
              # @see Msf::Java::Rmi::Builder.build_call
              def build_jmx_get_object_instance(opts = {})
                object_number = opts[:object_number] || 0
                uid_number = opts[:uid_number] || 0
                uid_time = opts[:uid_time] || 0
                uid_count = opts[:uid_count] || 0
                name = opts[:name] || ''

                arguments = build_jmx_get_object_instance_args(name)

                method_hash = calculate_method_hash('getObjectInstance(Ljavax/management/ObjectName;Ljavax/security/auth/Subject;)Ljavax/management/ObjectInstance;')

                call = build_call(
                  object_number: object_number,
                  uid_number: uid_number,
                  uid_time: uid_time,
                  uid_count: uid_count,
                  operation: -1,
                  hash: method_hash,
                  arguments: arguments
                )

                call
              end

              # Builds an an array of arguments o build a call to
              # javax/management/remote/rmi/RMIConnectionImpl_Stub#getObjectInstance()
              #
              # @param opts [Hash]
              # @option opts [String] :name the MBean name
              # @return [Array]
              def build_jmx_get_object_instance_args(name = '')
                builder = Rex::Java::Serialization::Builder.new

                new_object = builder.new_object(
                  name: 'javax.management.ObjectName',
                  serial: Msf::Java::Rmi::Client::Jmx::OBJECT_NAME_UID, # serialVersionUID
                  flags: 3
                )

                arguments = [
                  new_object,
                  Rex::Java::Serialization::Model::Utf.new(nil, name),
                  Rex::Java::Serialization::Model::EndBlockData.new,
                  Rex::Java::Serialization::Model::NullReference.new
                ]

                arguments
              end

              # Builds an RMI call to javax/management/remote/rmi/RMIConnectionImpl_Stub#createMBean()
              # used to retrieve an MBean instance
              #
              # @param opts [Hash]
              # @option opts [String] :name the MBean name
              # @return [Rex::Proto::Rmi::Model::Call]
              # @see Msf::Java::Rmi::Builder.build_call
              def build_jmx_create_mbean(opts = {})
                name = opts[:name] || ''
                object_number = opts[:object_number] || 0
                uid_number = opts[:uid_number] || 0
                uid_time = opts[:uid_time] || 0
                uid_count = opts[:uid_count] || 0

                method_hash = calculate_method_hash('createMBean(Ljava/lang/String;Ljavax/management/ObjectName;Ljavax/security/auth/Subject;)Ljavax/management/ObjectInstance;')

                arguments = build_jmx_create_mbean_args(name)

                call = build_call(
                  object_number: object_number,
                  uid_number: uid_number,
                  uid_time: uid_time,
                  uid_count: uid_count,
                  operation: -1,
                  hash: method_hash,
                  arguments: arguments
                )

                call
              end

              # Builds an an array of arguments o build a call to
              # javax/management/remote/rmi/RMIConnectionImpl_Stub#createMBean()
              #
              # @param opts [Hash]
              # @option opts [String] :name the MBean name
              # @return [Array]
              def build_jmx_create_mbean_args(name = '')
                arguments = [
                  Rex::Java::Serialization::Model::Utf.new(nil, name),
                  Rex::Java::Serialization::Model::NullReference.new,
                  Rex::Java::Serialization::Model::NullReference.new
                ]

                arguments
              end
            end


            # Builds an RMI call to javax/management/remote/rmi/RMIConnectionImpl_Stub#invoke()
            # used to invoke an MBean method
            #
            # @param opts [Hash]
            # @option opts [String] :name the MBean name
            # @return [Rex::Proto::Rmi::Model::Call]
            # @see Msf::Java::Rmi::Builder.build_call
            # @see #build_jmx_invoke_args
            def build_jmx_invoke(opts = {})
              object_number = opts[:object_number] || 0
              uid_number = opts[:uid_number] || 0
              uid_time = opts[:uid_time] || 0
              uid_count = opts[:uid_count] || 0

              method_hash = calculate_method_hash('invoke(Ljavax/management/ObjectName;Ljava/lang/String;Ljava/rmi/MarshalledObject;[Ljava/lang/String;Ljavax/security/auth/Subject;)Ljava/lang/Object;')

              arguments = build_jmx_invoke_args(opts)

              call = build_call(
                object_number: object_number,
                uid_number: uid_number,
                uid_time: uid_time,
                uid_count: uid_count,
                operation: -1,
                hash: method_hash,
                arguments: arguments
              )

              call
            end

            # Builds an an array of arguments o build a call to
            # javax/management/remote/rmi/RMIConnectionImpl_Stub#invoke()
            #
            # @param opts [Hash]
            # @option opts [String] :object the MBean name
            # @option opts [String] :method the method name
            # @option opts [Hash] :args the method arguments
            # @return [Array]
            def build_jmx_invoke_args(opts = {})
              object_name = opts[:object] || ''
              method_name = opts[:method] || ''
              args = opts[:args] || {}

              builder = Rex::Java::Serialization::Builder.new

              new_object = builder.new_object(
                name: 'javax.management.ObjectName',
                serial: Msf::Java::Rmi::Client::Jmx::OBJECT_NAME_UID, # serialVersionUID
                flags: 3
              )

              data_binary = builder.new_array(
                name: '[B',
                serial: Msf::Java::Rmi::Client::Jmx::BYTE_ARRAY_UID, # serialVersionUID
                values_type: 'byte',
                values: build_invoke_arguments_obj_bytes(args).encode.unpack('C*')
              )

              marshall_object = builder.new_object(
                name: 'java.rmi.MarshalledObject',
                serial: Msf::Java::Rmi::Client::Jmx::MARSHALLED_OBJECT_UID, # serialVersionUID
                fields: [
                  ['int', 'hash'],
                  ['array', 'locBytes', '[B'],
                  ['array', 'objBytes', '[B']
                ],
                data: [
                  ["int", 1919492550],
                  Rex::Java::Serialization::Model::NullReference.new,
                  data_binary
                ]
              )

              new_array = builder.new_array(
                name: '[Ljava.lang.String;',
                serial: Msf::Java::Rmi::Client::Jmx::STRING_ARRAY_UID, # serialVersionUID
                values_type: 'java.lang.String;',
                values: args.keys.collect { |k| Rex::Java::Serialization::Model::Utf.new(nil, k) }
              )

              arguments = [
                new_object,
                Rex::Java::Serialization::Model::Utf.new(nil, object_name),
                Rex::Java::Serialization::Model::EndBlockData.new,
                Rex::Java::Serialization::Model::Utf.new(nil, method_name),
                marshall_object,
                new_array,
                Rex::Java::Serialization::Model::NullReference.new
              ]

              arguments
            end

            # Builds a Rex::Java::Serialization::Model::Stream with the arguments to
            # simulate a call to the Java javax/management/remote/rmi/RMIConnectionImpl_Stub#invoke()
            # method.
            #
            # @param args [Hash] the arguments of the method to invoke
            # @return [Rex::Java::Serialization::Model::Stream]
            def build_invoke_arguments_obj_bytes(args = {})
              builder = Rex::Java::Serialization::Builder.new

              new_array = builder.new_array(
                name: '[Ljava.lang.Object;',
                serial: Msf::Java::Rmi::Client::Jmx::OBJECT_ARRAY_UID, # serialVersionUID
                annotations: [Rex::Java::Serialization::Model::EndBlockData.new],
                values_type: 'java.lang.Object;',
                values: args.values.collect { |arg| Rex::Java::Serialization::Model::Utf.new(nil, arg) }
              )

              stream = Rex::Java::Serialization::Model::Stream.new
              stream.contents << new_array

              stream
            end
          end
        end
      end
    end
  end
end
