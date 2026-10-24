import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client%20.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/signup_req_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/signup_res_model.dart';

class SignupService {
  ApiClient apiClient;
  SignupService(this.apiClient);
  Future<signupResmodel> signUp(SignupReqModel signupreqmodel) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.signupEndpoint,
      data: {
        "email": signupreqmodel.name,
        "name": signupreqmodel.email,
        "password": signupreqmodel.password,

        "avatar": "data:image/webp;base64,UklGRtQDAABXRUJQVlA4IMgDAADQEgCdASpjAGsAPwVYwWCru6urkqNwIIlnBvjmadGHWAucDd1VQ8t3j3wCl/uAcMVgRltrifUGem1VN6RRF/iHnTC9mDPyqo55icsWHcjKB0eUZ+5m4kIiZG+5qn+whJGXuyic5Bmtz/tTdM8bb9B307bEo54qOQWJOtDlnB1Asv4INMBfJpJl/3KBQZT9D0XNyPkh2PfGNxyVxaO4vAAA/vMCgDQEZcQn6NG9FbBRJUaTWTNRvpDfYBsLUQmq7FjQw+sPdYgM/4Ty0Ou8i5mX2skoB4jQbcEFjwqhVGTKf3TA56m/eK7YEhpmvBWXmwqb+vuTGu8VRb20wN88ynl674mWpXtW+ppA3HyAWhpY2HOCsbXqYgW3BkZk547j7q5z2z21EJ9tCyp/7LUU6Oo4AvMbzP01dFqGRxoO8IU1d3mOwWU+lBzsS0++Un+j9ULhHDP4s5YSII6tX7YT+/VGk3rpI6Wv2us779Q/hmUjKX/OCEpLQB0fljuCBVLqrfao5LuHbq5uQK4ISjDbm5/sTvhrGJMW8AX3ekJ/TEsvs6eNRnIIFb7Q9Ah9AJBlnsoPPHnZjyCZgOumnuVWpf3HHMgrL1SqZ5sRVZ1cpv1PfKOkNIVQJ86NV8Y0a0PXedwjaRdpEsUBGqXPWtLPaquD9SesUeNsBlzwPVHHvYskLKxcQZhIsa1jI62+5WJrBDJEgRw/AmBPBqok2699sSf3/75vDwhDVURCJSvJSKkW+h/wQjkYSubmQj0DZTCOlgPdBUy16LDDog1CMXpptJqrihvM5QXDyieXQZiH0TslTsVsyGxS2z0hQQKYV2zbm4wLwZmCzsdS9MlOhX5k1HR+huokIDjZPYfm7JB3R1JXJV+yxhxO6kli7BZ8lk/97ggmKtpZqcsShOZ3Y97Cqsp0eW/8COct32Y3PBrlQs17d1xze1E7OlryDWSW/Gliow2F8Nkeiop88GFMWyAyV+HxstEskWD62TcGWQnarIZb4P7JnQbmZFiFStfdxu7Dq/vPaASmfz0//E3X5YK7vfeUZc1Mpcd+7XuU2QY+M6pq2W04ttmK4gJ/gKAeY27l6oZmcvPO7eoiXvF2T4wkDvpv4SgGhnsJCAMfLiYpcEdRKT7osl5S8M4OdAeD/sL3mJ6DuC+8K5BuqIogP10JuoKoUoiJR1tf3vq2dak1xHXvl/AyFnaMvMoS0JJez+Z9TM9ViA139Hw5w955DlvJNumPUs1nsqBzfSEsNV7akNL/WnA/JP7YLobGSG91xZPpdjdv1DhJuAYAAA==",
      },
    );

    final JsonData = response.data;
    final dartData = signupResmodel.fromJson(JsonData);
    return dartData;
  }
}
