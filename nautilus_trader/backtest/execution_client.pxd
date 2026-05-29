# -------------------------------------------------------------------------------------------------
#  Copyright (C) 2015-2026 Nautech Systems Pty Ltd. All rights reserved.
#  https://nautechsystems.io
#
#  Licensed under the GNU Lesser General Public License Version 3.0 (the "License");
#  You may not use this file except in compliance with the License.
#  You may obtain a copy of the License at https://www.gnu.org/licenses/lgpl-3.0.en.html
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
# -------------------------------------------------------------------------------------------------

from nautilus_trader.backtest.engine cimport SimulatedExchange
from nautilus_trader.execution.client cimport ExecutionClient
# 【新增 1】从消息模块中 C-Import 我们刚刚写好的批量修改命令类
from nautilus_trader.execution.messages cimport ModifyOrderList


cdef class BacktestExecClient(ExecutionClient):
    cdef SimulatedExchange _exchange

    # 【新增 2】在这里声明你的新函数，注意和上面的 cdef 保持同样的缩进
    cpdef void modify_order_list(self, ModifyOrderList command)