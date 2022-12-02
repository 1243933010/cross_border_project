// const baseUrl = 'https://shop.zyjsl.com/api';
const baseUrl = 'https://sit.zyjsl.com/api';
const servicePath = {
  'getDiyDefault':'$baseUrl/v2/diy/get_diy/default',//获取默认数据
  'getCoupons':'$baseUrl/coupons',//首页优惠券展示
  'getHomeProducts':'$baseUrl/home/products',
  'category':"$baseUrl/category",   //商品分类接口
  'user':'$baseUrl/user',       //用户信息
  'userMenu':'$baseUrl/menu/user',     //个人中心菜单
  'productHot':'$baseUrl/product/hot',  //购物车推荐商品
  'cartList':'$baseUrl/cart/list', //购物车数据
  'cartCount':'$baseUrl/cart/count', //购物车数量
  'cartNum':'$baseUrl/cart/num', //购物车数量修改
  'cartDel':'$baseUrl/cart/del', //购物车商品删除
  'getCouponsList':'$baseUrl/v2/coupons',//优惠券列表
  'articleBannerList':'$baseUrl/article/banner/list',//资讯轮播列表
  'articleHotList':'$baseUrl/article/hot/list',//热门列表
  'articleCategoryList':'$baseUrl/article/category/list',//文章列表


};

groomList(String id){  //精品页数据
  return '${baseUrl}/groom/list/${id.toString()}';
}