## command list
1. `sed -i 's/-relevance_filter=true/&\n-not_get_pc_userid=true/g' z?/ad.gflags`
1. `sed -i 's/pos_retrieval\(.*\)/&\n# 不获取用户行为信息\npos_no_get_pc_userid = 1741,1791/g' z?/server.ini`
