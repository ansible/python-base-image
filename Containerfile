# Copyright (c) 2019 Red Hat, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at:
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM docker.io/centos:8

# NOTE(pabelanger): Until centos 8.3 container images is published to
# docker.io/centos:8 we need to exclude filesystem from updating. See
# https://bugs.centos.org/view.php?id=17915
RUN echo -n "exclude=filesystem" >> /etc/dnf/dnf.conf

RUN dnf update -y \
  && dnf install -y python3-pip \
  && dnf clean all \
  && rm -rf /var/cache/dnf

RUN pip3 install --no-cache-dir dumb-init

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
