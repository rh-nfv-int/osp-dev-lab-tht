echo "Creating roles..."
openstack overcloud roles generate -o $HOME/roles_data.yaml ControllerSriov ComputeOvsDpdkSriov

openstack overcloud deploy $PARAMS \
    --templates /usr/share/openstack-tripleo-heat-templates \
    --timeout 120 --ntp-server clock1.rdu2.redhat.com \
    --stack overcloud \
    --network-config \
    -r /home/stack/roles_data.yaml \
    --deployed-server \
    --baremetal-deployment /home/stack/osp17_ref/network/baremetal_deployment.yaml \
    --vip-file /home/stack/osp17_ref/network/vip_data.yaml \
    -n /home/stack/osp17_ref/network/network_data_v2.yaml \
    -e /usr/share/openstack-tripleo-heat-templates/environments/disable-telemetry.yaml \
    -e /usr/share/openstack-tripleo-heat-templates/environments/debug.yaml \
    -e /usr/share/openstack-tripleo-heat-templates/environments/config-debug.yaml \
    -e /home/stack/osp17_ref/network-environment.yaml \
    -e /home/stack/osp17_ref/network-environment-regular.yaml \
    -e /home/stack/osp17_ref/ml2-ovs-nfv.yaml \
    -e /home/stack/containers-prepare-parameter.yaml \
    --log-file overcloud_deployment.log
