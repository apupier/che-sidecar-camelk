# Copyright (c) 2020 Red Hat, Inc.
# This program and the accompanying materials are made
# available under the terms of the Eclipse Public License 2.0
# which is available at https://www.eclipse.org/legal/epl-2.0/
#
# SPDX-License-Identifier: EPL-2.0
#
# Contributors:
#   Red Hat, Inc. - initial API and implementation
FROM quay.io/eclipse/che-sidecar-kubernetes-tooling:1.0.4-a46d022
# maybe better to inherit from openshift-connector sidecar but it seems that helm is missing
# and it is base don alpine instead of some buildah which should be more recent
# it would avoid to add the specific oc and odo stuff in this dockerfile
 
ENV KAMEL_VERSION=1.0.0-RC1 \
    ODO_VERSION=v1.0.1 \
    OC_VERSION=v3.11.0 \
    OC_TAG=0cbc58b

# install kamel
RUN curl -L https://github.com/apache/camel-k/releases/download/${KAMEL_VERSION}/camel-k-client-${KAMEL_VERSION}-linux-64bit.tar.gz | tar -C /usr/local/bin -xz \
    && chmod +x /usr/local/bin/kamel
# install oc
RUN curl -L https://github.com/openshift/origin/releases/download/${OC_VERSION}/openshift-origin-client-tools-${OC_VERSION}-${OC_TAG}-linux-64bit.tar.gz | tar -C /usr/local/bin -xz --strip 1
# install odo
RUN curl -o /usr/local/bin/odo -L https://mirror.openshift.com/pub/openshift-v4/clients/odo/${ODO_VERSION}/odo-linux-amd64 && \
    chmod +x /usr/local/bin/odo

