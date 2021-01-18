# 阅读笔记：Blockchain-Based Location Proof Generation and Verification

## 架构设计

### 整体结构

- Prover+Witness：进行位置信息的验证
- Bridge：局部通信与互联网的连接点，汇总交易（验证）信息
- LBSP（Location-based Service Provider）：第三方，确认Prover位置合法后为之提供服务

### 请求

$$
m_1=\bar{m_1}||r=ID_P||H(Prev_{T_x})||Index||Reward||C_{(P,ST)}||r
$$

- Reward：P向W或B提供的奖励，减少P-W合谋攻击
- $C_{(P,ST)}=Commit(ST,r)$：ST为用户的时空数据，r为产生的nonce，防止恶意用户提交不同的位置信息

### 验证与交易生成

- Witness：检查时空数据与实际情况是否相符。发送m2消息，开启计时：

$$
m_2^j=LP_j||Sign_{w_j}(LP_j)=\bar{m_1}||n{j||ID_{w_j}}||ID_b
$$

- Prover：对m2加上自己的签名，表示同意为这个验证支付奖励：

$$
m_3^j=m_2^j||Sign_{P}(m_2^j)
$$

- Witness：停止计时，确保自己在规定时间内收到了m3消息，用于防止P-P合谋。成功收到后生成交易信息（若m3未在规定时间内收到，则交易信息中添加$Nack$标志），发送给Bridge：

$$
T_{x_j}=m_3^j||Sign_{w_j}(m_3^j)
$$

- Bridge：检查自己的ID在消息中被指定，丢弃可能的多余交易信息；加上自己签名，发送到互联网上：

$$
m_4^j=T_{x_j}||Sign_{B}(T_{x_j})
$$

### 交易验证

验证内容：

- Prover、Witness、Bridge的数字签名均有效
- Prover提供的奖励Reward大于规定的最小值
- 对于该Prover的有效位置验证（满足上述规定且非$Nack$）至少有$J_1$个
  - 用于防范P-W合谋攻击

如果满足上述条件，验证者可从这些交易中随机挑选一个加入正在创建的区块中。生成下一个区块的验证者由PoS（Proof-of-Stake）算法确定。



## 安全性

### 时空数据的隐私性

### P-P合谋

一个Prover代替另一个Prover发送位置验证请求，使用自己的位置信息和后者的身份信息。

可通过设置合适的T参数进行防范（Witness从发送m2到接收m3消息的时间）。

### P-W合谋

一个恶意Witness为一个Prover生成虚假的位置验证成功交易信息。

- Witness通过Bridge发送交易信息：必须同时为Prover伪造相应的请求，情况与P-P合谋类似
- Witness直接将交易信息发送到网上：验证者处需要的成功交易数有最小值$J_1$，成功欺骗需要与多个设备合谋，成本较大