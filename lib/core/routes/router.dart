import 'package:basetime/features/auth/auth_page.dart';
import 'package:basetime/features/auth/forgot_password_page.dart';
import 'package:basetime/features/auth/sign_in_page.dart';
import 'package:basetime/features/auth/sign_up_page.dart';
import 'package:basetime/features/auth/user_entity.dart';
import 'package:basetime/features/bank_accounts/add_bank_account_form.dart';
import 'package:basetime/features/bank_accounts/add_bank_account_page.dart';
import 'package:basetime/features/categories/category_entity.dart';
import 'package:basetime/features/chats/chat.dart';
import 'package:basetime/features/chats/chat_page.dart';
import 'package:basetime/features/checkout/checkout_page.dart';
import 'package:basetime/features/checkout/payment_failed_page.dart';
import 'package:basetime/features/checkout/payment_success_page.dart';
import 'package:basetime/features/feed/feed_details.dart';
import 'package:basetime/features/home/home_page.dart';
import 'package:basetime/features/matches/match.dart';
import 'package:basetime/features/meets/meet.dart';
import 'package:basetime/features/meets/meet_page.dart';
import 'package:basetime/features/my_account/my_account_page.dart';
import 'package:basetime/features/my_account/selected_categories.dart';
import 'package:basetime/features/my_account/selected_sub_categories.dart';
import 'package:basetime/features/notifications/notifications_page.dart';
import 'package:basetime/features/onboarding/onboarding_page.dart';
import 'package:basetime/features/pay_movements/movement.dart';
import 'package:basetime/features/pay_movements/movement_details.dart';
import 'package:basetime/features/payments/add_payment_method_form.dart';
import 'package:basetime/features/payments/add_payment_method_page.dart';
import 'package:basetime/features/payments/payment_method.dart';
import 'package:basetime/features/payments/payments_page.dart';
import 'package:basetime/features/skills/add_skill_form.dart';
import 'package:basetime/features/skills/edit_skill_form.dart';
import 'package:basetime/features/skills/skill_entity.dart';
import 'package:basetime/features/skills/skills_page.dart';
import 'package:basetime/features/sub_categories/sub_categories_page.dart';
import 'package:basetime/features/verification/verification_page.dart';
import 'package:basetime/features/verification/verification_success.dart';
import 'package:basetime/features/wallet/wallet_page.dart';
import 'package:basetime/features/welcome/welcome_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

final _key = GlobalKey<NavigatorState>();

@riverpod
GoRouter router(Ref ref) {
  return GoRouter(
    navigatorKey: _key,
    debugLogDiagnostics: true,
    initialLocation: WelcomePage.path,
    routes: [
      /// Welcome
      GoRoute(
        name: WelcomePage.name,
        path: WelcomePage.path,
        builder: (context, state) {
          return const WelcomePage();
        },
      ),

      /// Onboarding
      GoRoute(
        name: OnboardingPage.name,
        path: OnboardingPage.path,
        builder: (context, state) {
          return const OnboardingPage();
        },
      ),

      /// Auth
      GoRoute(
        name: AuthPage.name,
        path: AuthPage.path,
        builder: (context, state) {
          return const AuthPage();
        },
      ),

      /// Sign in
      GoRoute(
        name: SignInPage.name,
        path: SignInPage.path,
        builder: (context, state) {
          return const SignInPage();
        },
      ),

      /// Sign up
      GoRoute(
        name: SignUpPage.name,
        path: SignUpPage.path,
        builder: (context, state) {
          return const SignUpPage();
        },
      ),

      /// Forgot password page
      GoRoute(
        name: ForgotPasswordPage.name,
        path: ForgotPasswordPage.path,
        builder: (context, state) {
          return const ForgotPasswordPage();
        },
      ),

      /// Home page
      GoRoute(
        name: HomePage.name,
        path: HomePage.path,
        builder: (context, state) {
          return const HomePage();
        },
      ),

      /// Notifications page
      GoRoute(
        name: NotificationsPage.name,
        path: NotificationsPage.path,
        builder: (context, state) {
          return const NotificationsPage();
        },
      ),

      /// Sub Categories
      GoRoute(
        name: SubCategoriesPage.name,
        path: SubCategoriesPage.path,
        builder: (context, state) {
          final categories = state.extra as List<CategoryEntity>;
          return SubCategoriesPage(
            categories: categories,
          );
        },
      ),

      /// Skills
      GoRoute(
        name: SkillsPage.name,
        path: SkillsPage.path,
        builder: (context, state) {
          return const SkillsPage();
        },
      ),

      /// Add Skill Form
      GoRoute(
        name: AddSkillForm.name,
        path: AddSkillForm.path,
        builder: (context, state) {
          return const AddSkillForm();
        },
      ),

      /// Edit Skill Form
      GoRoute(
        name: EditSkillForm.name,
        path: EditSkillForm.path,
        builder: (context, state) {
          final skill = state.extra as Skill;
          return EditSkillForm(skill: skill);
        },
      ),

      /// My Account
      GoRoute(
        name: MyAccountPage.name,
        path: MyAccountPage.path,
        builder: (context, state) {
          return const MyAccountPage();
        },
      ),

      /// Verification
      GoRoute(
        name: VerificationPage.name,
        path: VerificationPage.path,
        builder: (context, state) {
          return const VerificationPage();
        },
      ),

      /// Verification success
      GoRoute(
        name: VerificationSuccess.name,
        path: VerificationSuccess.path,
        builder: (context, state) {
          return const VerificationSuccess();
        },
      ),

      /// Payments
      GoRoute(
        name: PaymentsPage.name,
        path: PaymentsPage.path,
        builder: (context, state) {
          return const PaymentsPage();
        },
      ),

      /// Add Payment Method
      GoRoute(
        name: AddPaymentMethodPage.name,
        path: AddPaymentMethodPage.path,
        builder: (context, state) {
          return const AddPaymentMethodPage();
        },
      ),

      /// Add Payment Method Form
      GoRoute(
        name: AddPaymentMethodForm.name,
        path: AddPaymentMethodForm.path,
        builder: (context, state) {
          final type = state.extra as PaymentMethodType;
          return AddPaymentMethodForm(
            type: type,
          );
        },
      ),

      /// Feed Details
      GoRoute(
        name: FeedDetails.name,
        path: FeedDetails.path,
        builder: (context, state) {
          final user = state.extra as UserEntity;
          return FeedDetails(user: user);
        },
      ),

      /// Chat
      GoRoute(
        name: ChatPage.name,
        path: ChatPage.path,
        builder: (context, state) {
          final match = state.extra as MatchModel;
          return ChatPage(match: match);
        },
      ),

      /// Checkout
      GoRoute(
        name: CheckoutPage.name,
        path: CheckoutPage.path,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final match = extra['match'] as MatchModel;
          final chat = extra['chat'] as Chat;
          final meet = extra['meet'] as Meet;
          return CheckoutPage(
            match: match,
            chat: chat,
            meet: meet,
          );
        },
      ),

      /// Payment success
      GoRoute(
        name: PaymentSuccessPage.name,
        path: PaymentSuccessPage.path,
        builder: (context, state) {
          return const PaymentSuccessPage();
        },
      ),

      /// Payment failed
      GoRoute(
        name: PaymentFailedPage.name,
        path: PaymentFailedPage.path,
        builder: (context, state) {
          return const PaymentFailedPage();
        },
      ),

      /// Meet
      GoRoute(
        name: MeetPage.name,
        path: MeetPage.path,
        builder: (context, state) {
          final json = state.extra as Map<String, dynamic>;
          final chat = json['chat'] as Chat;
          final meet = json['meet'] as Meet;
          final match = json['match'] as MatchModel;

          return MeetPage(
            meet: meet,
            chat: chat,
            match: match,
          );
        },
      ),

      /// Add Bank Account
      GoRoute(
        name: AddBankAccountPage.name,
        path: AddBankAccountPage.path,
        builder: (context, state) {
          return const AddBankAccountPage();
        },
      ),

      GoRoute(
        name: AddBankAccountForm.name,
        path: AddBankAccountForm.path,
        builder: (context, state) {
          final AccountType accountType = state.extra as AccountType;
          return AddBankAccountForm(
            accountType: accountType,
          );
        },
      ),

      /// BTP points
      GoRoute(
        name: WalletPage.name,
        path: WalletPage.path,
        builder: (context, state) => const WalletPage(),
      ),

      /// Movement Details
      GoRoute(
        path: MovementDetails.path,
        builder: (context, state) {
          final movement = state.extra as Movement;
          return MovementDetails(
            movement: movement,
          );
        },
      ),

      /// Edit Categories
      GoRoute(
          name: SelectCategories.name,
          path: SelectCategories.path,
          builder: (context, state) {
            return const SelectCategories();
          }),

      /// Edit sub categories
      GoRoute(
        name: SelectedSubCategories.name,
        path: SelectedSubCategories.path,
        builder: (context, state) {
          return const SelectedSubCategories();
        },
      ),
    ],
  );
}
