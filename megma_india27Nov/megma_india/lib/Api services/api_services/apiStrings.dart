import 'apiConstants.dart';

final Uri getRoleurl = Uri.parse('${baseUrl}user_roles');
final Uri registerUrl = Uri.parse('${baseUrl}register');
final Uri loginUrl = Uri.parse('${baseUrl}login');
final Uri forgetPasswordUrl = Uri.parse('${baseUrl}forgot_password');
final Uri updatePasswordUrl = Uri.parse('${baseUrl}update_password');
final Uri veryfieUrl = Uri.parse('${baseUrl}verifyotp');
final Uri getBannerUrl = Uri.parse('${baseUrl}get_banners');
final Uri getBrandsUrl = Uri.parse('${baseUrl}get_brands');
final Uri getprivecyUrl = Uri.parse('${baseUrl}policies?slug=');
final Uri getfaqsUrl = Uri.parse('${baseUrl}faqs');
final Uri updateprofileUrl = Uri.parse('${baseUrl}update_profile');
final Uri getprofileUrl = Uri.parse('${baseUrl}get_profile');
final Uri getcatogryUrl = Uri.parse('${baseUrl}get_category');
final Uri getProductUrl = Uri.parse('${baseUrl}all_prodoucts?subcategory_id=');
final Uri getProductForSellerUrl = Uri.parse('${baseUrl}customer_products');
final Uri getsubCatUrl = Uri.parse('${baseUrl}get_subcategory');
final Uri getproductdetailsUrl = Uri.parse('${baseUrl}product_details');
final Uri getSellersUrl = Uri.parse('${baseUrl}get_sellers');
final Uri getCartUrl = Uri.parse('${baseUrl}view_cart');
final Uri removeCartUrl = Uri.parse('${baseUrl}remove_cart_item');
final Uri placeOrderUrl = Uri.parse('${baseUrl}place_order');
final Uri myOrderUrl = Uri.parse('${baseUrl}my_orders');
final Uri myReceivedOrderUrl = Uri.parse('${baseUrl}my_receiving_orders');
final Uri myOrderDetailUrl = Uri.parse('${baseUrl}order_details');
final Uri acceptRejectOrderBuyerUrl = Uri.parse('${baseUrl}update_order_approval_status');
final Uri sendOrderApprovalToBuyerUrl = Uri.parse('${baseUrl}send_order_approval_to_buyer');


final Uri addtocartUrl = Uri.parse('${baseUrl}add_to_cart');
final Uri viewcartUrl = Uri.parse('${baseUrl}view_cart');
final Uri daletecartItemUrl = Uri.parse('${baseUrl}remove_cart_item');
final Uri updatecartItemUrl = Uri.parse('${baseUrl}update_cart_item');
//mechanic api
final Uri uploadtemUrl = Uri.parse('${baseUrl}mechanic_uploads');
final Uri getWorkshopUrl = Uri.parse('${baseUrl}get_workshop_list');
final Uri getuploadListUrl = Uri.parse('${baseUrl}mechanic_upolads_list');
final Uri uploadedDetailsUrl = Uri.parse('${baseUrl}mechanic_upload_details');
final Uri addclamUrl = Uri.parse('${baseUrl}claim_warranty');
final Uri addclamListUrl = Uri.parse('${baseUrl}get_claim_warranty_list');


