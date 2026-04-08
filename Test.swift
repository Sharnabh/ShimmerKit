//
//  HomeView.swift
//  BulkMart
//
//  Created by Sharnabh on 12/03/26.
//

import SwiftUI
import Kingfisher
import ShimmerKit

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject private var addressViewModel: AddressViewModel
    @EnvironmentObject var router: AppRouter

    @State private var isFetching = false

    let bridgeGap: CGFloat = 16
    private let loadingConfig = ShimmerKit.config(.feedLoading)

    var body: some View {
        ScrollView{
            VStack(spacing: 0) {
                VStack {
                    NavigationLink(value: AppRoute.address) {
                        VStack(alignment: .leading) {
                            HStack {
                                Image("LocationPin")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 12)
                                    .padding(.horizontal, 8)

                                if !addressViewModel.addressList.isEmpty {
                                    let address = addressViewModel.addressList.first(where: {$0.isDefault == "1"})?.address ?? ""
                                    Text("\(address)")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundStyle(Color.white)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 10)
                                } else {
                                    Text("Please add Address")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundStyle(Color.white)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 10)
                                }

                                Spacer()

                                Image(systemName: "chevron.forward")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundStyle(Color.white)
                                    .padding(.horizontal, 8)
                            }
                            .background(Color(hex: "#000042"))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .frame(height: 34)
                            .padding(.horizontal, 16)
                        }
                        .padding(.vertical, 16)
                    }

                    VStack(spacing: 0) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(viewModel.sections, id: \.self) { section in
                                    CategoryTabButton(
                                        title: section.name,
                                        isSelected: viewModel.selectedSection?.id == section.id,
                                        gap: bridgeGap
                                    ) {
                                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                            viewModel.selectedSection(section)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.bottom, bridgeGap)
                        }

                        VStack(spacing: 0) {
                            NavigationLink(value: AppRoute.searchProduct) {
                                SearchBarButton()
                            }
                            .buttonStyle(.plain)

                            if let banners = viewModel.selectedSection?.banners {
                                PromoCarouselView(banners: banners)
                                    .padding(.vertical, 16)
                            }

                            HStack {
                                Text("Categories")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundStyle(.white)

                                Spacer()

                                Button {
                                    router.selectedTab = .explore
                                } label: {
                                    Text("See all")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundStyle(.white)

                                    Image(systemName: "chevron.forward")
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundStyle(Color.white)
                                }
                            }
                            .padding(.horizontal, 16)

                            if let subCategories = viewModel.selectedSection?.categories {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(alignment: .top, spacing: 0) {
                                        ForEach(subCategories) { subCat in
                                            HeaderCategoryButtons(
                                                imageUrl: subCat.photo,
                                                category: subCat.name,
                                                categotyId: Int(subCat.id) ?? 0,
                                            )
                                        }
                                    }
                                    .padding(.all, 16)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .top)
                        .background(
                            Color(hex: "#FF6B00")
                                .ignoresSafeArea(edges: .bottom)
                        )
                        .clipShape(
                            UnevenRoundedRectangle(
                                bottomLeadingRadius: 20,
                                bottomTrailingRadius: 20
                            )
                        )
                    }
                }
                .background(Color(hex: "#000072"))
                .clipShape(
                    UnevenRoundedRectangle(
                        bottomLeadingRadius: 20,
                        bottomTrailingRadius: 20
                    )
                )
                .padding(.bottom, 28)

                VStack(spacing: 24) {
                    ForEach(viewModel.productModules) { module in

                        let shouldShowCategories = (module.moduleId == 8)
                        let categoriesToPass = shouldShowCategories ? viewModel.featuredCategories.flatMap { $0.items } : []

                        ProductModule(
                            title: module.title,
                            products: module.productData,
                            moduleId: module.moduleId,
                            showCategories: shouldShowCategories,
                            categories: categoriesToPass,
                            onOptionTap: { product in
                                viewModel.selectedProductForOptions = product
                            },
                            isLoading: viewModel.isLoading
                        )
                    }

                    ForEach(viewModel.featuredBrands) { brand in
                        let allBrands = viewModel.featuredBrands.flatMap { $0.items }
                        BrandGridModule(title: brand.title, brands: allBrands)
                    }
                }
                .padding(.bottom, 16)
            }
            .background(Color.white)
        }
        .background(
            VStack(spacing: 0) {
                Color(hex: "#000072").ignoresSafeArea(edges: .top)
                Color.white.ignoresSafeArea(edges: .bottom)
            }
        )
        .refreshable {
            await viewModel.loadAllDataIfNeeded(addressVM: addressViewModel)
        }
        .task {
            await viewModel.loadAllDataIfNeeded(addressVM: addressViewModel)
        }
        .scrollIndicators(.hidden, axes: .vertical)
        .sheet(item: $viewModel.selectedProductForOptions) { product in
            ProductOptionsSheet(viewData: product.toSheetViewData())
                .presentationDragIndicator(.visible)
        }
        .onAppear {
            UIRefreshControl.appearance().tintColor = UIColor(red: 255/255, green: 91/255, blue: 0/255, alpha: 1)
        }
        .shimmerLoading(viewModel.isLoading, config: loadingConfig) {
            HomeLoadingPlaceholderView(config: loadingConfig)
        }
    }
}

// MARK: - Subviews

struct CategoryTabButton: View {
    let title: String
    let isSelected: Bool
    let gap: CGFloat
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 15, weight: .heavy))
                .foregroundColor(isSelected ? .white : Color(hex: "#1D2733"))
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(
                    ZStack {
                        if isSelected {
                            BridgedTabShape(radius: 15, gap: gap)
                                .fill(Color(hex: "#FF6B00"))
                        } else {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                .background(RoundedRectangle(cornerRadius: 12).fill(Color(hex: "#F5F7F9")))
                        }
                    }
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct BridgedTabShape: Shape {
    var radius: CGFloat = 15
    var gap: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX - radius, y: rect.maxY + gap))

        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY + gap - radius),
                          control: CGPoint(x: rect.minX, y: rect.maxY + gap))

        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + radius))

        path.addArc(center: CGPoint(x: rect.minX + radius, y: rect.minY + radius),
                    radius: radius, startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)

        path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.minY + radius),
                    radius: radius, startAngle: .degrees(270), endAngle: .degrees(0), clockwise: false)

        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY + gap - radius))

        path.addQuadCurve(to: CGPoint(x: rect.maxX + radius, y: rect.maxY + gap),
                          control: CGPoint(x: rect.maxX, y: rect.maxY + gap))

        path.addLine(to: CGPoint(x: rect.minX - radius, y: rect.maxY + gap))

        return path
    }
}

struct PromoCarouselView: View {
    let banners: [HomeBanner]

    // 1. Add state to track the active banner
    @State private var currentBannerIndex: Int = 0

    var body: some View {
        // 2. Bind the TabView to the current index
        TabView(selection: $currentBannerIndex) {
            // 3. Iterate over the indices so we have an exact integer to tag
            ForEach(banners.indices, id: \.self) { index in
                let banner = banners[index]

                Group {
                    if let url = URL(string: banner.banner) {
                        KFImage(url)
                            .placeholder {
                                ProgressView()
                            }
                            .retry(maxCount: 2, interval: .seconds(2))
                            .fade(duration: 0.25)
                            .setProcessor(
                                DownsamplingImageProcessor(size: CGSize(width: 400, height: 180))
                            )
                            .scaleFactor(UIScreen.main.scale)
                            .cacheOriginalImage()
                            .resizable()
                            .scaledToFill()
                            .frame(height: 180)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.horizontal, 20)
                    } else {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.gray.opacity(0.2))
                            Image(systemName: "photo")
                                .foregroundColor(.gray)
                        }
                        .frame(height: 180)
                        .padding(.horizontal, 20)
                    }
                }
                // 4. Tag the view so the TabView knows its index
                .tag(index)
            }
        }
        .frame(height: 180)
        // 5. Hide the default UIKit dots
        .tabViewStyle(.page(indexDisplayMode: .never))
        // 6. Overlay your custom dots
        .overlay(alignment: .bottom) {
            HStack(spacing: 8) {
                ForEach(banners.indices, id: \.self) { index in
                    Circle()
                        // Use your brand orange for the active dot
                        .fill(currentBannerIndex == index ? Color(hex: "#FF6B00") : Color.white.opacity(0.6))
                        .frame(width: 8, height: 8)
                        .scaleEffect(currentBannerIndex == index ? 1.2 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: currentBannerIndex)
                }
            }
            // Pushes the dots slightly up so they sit nicely inside the bottom edge of the banner
            .padding(.bottom, 12)
        }
    }
}

struct HeaderCategoryButtons: View {
    let imageUrl: String
    let category: String
    let categotyId: Int


    var body: some View {
        NavigationLink(value: SeeAllNavigationContext(title: category, categoryId: categotyId)) {
            VStack(spacing: 8) {
                ZStack {
                    Circle()
                        .fill(.white)
                        .frame(width: 50, height: 50)

                    KFImage(URL(string: imageUrl))
                        .placeholder {
                            ProgressView().scaleEffect(0.8)
                        }
                        .setProcessor(
                            DownsamplingImageProcessor(size: CGSize(width: 200, height: 200))
                        )
                        .scaleFactor(UIScreen.main.scale)
                        .cacheOriginalImage()
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)

                }

                Text(category)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: 65)
            }
        }
        .buttonStyle(.plain)
    }
}

struct ProductModule: View {
    let title: String
    let products: [FeaturedSectionData]
    let moduleId: Int

    let showCategories: Bool
    let categories: [FeaturedCategoryItem]

    var onOptionTap: ((FeaturedSectionData) -> Void)?

    let isLoading: Bool


    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color.black)

                Spacer()

                NavigationLink(value: SeeAllNavigationContext(title: title, moduleId: moduleId)) {
                    HStack(spacing: 4) {
                        Text("See all")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(Color(hex: "#53B175"))

                        Image(systemName: "chevron.right")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(Color(hex: "#53B175"))
                    }
                }
                .buttonStyle(.plain)

            }
            .padding(.horizontal, 16)

            if showCategories && !categories.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(categories, id: \.categoryId) { category in
                            NavigationLink(value: SeeAllNavigationContext(title: category.categoryName, categoryId: Int(category.categoryId))) {
                                KFImage(URL(string: category.banner))
                                    .placeholder {
                                        ProgressView()
                                    }
                                    .setProcessor(
                                        DownsamplingImageProcessor(size: CGSize(width: 200, height: 200))
                                    )
                                    .scaleFactor(UIScreen.main.scale)
                                    .cacheOriginalImage()
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 160, height: 200)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 12)
                                    )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.vertical, -8)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(products) { product in
                        let availableVariants = product.variants.filter { $0.variantRecordType != "default" }

                        let variantToShow = availableVariants.first(where: { String($0.variantId) == product.variantIdToShow }) ?? availableVariants.first
                        let actualOptionsCount = availableVariants.count

                        let packQty = (variantToShow?.packQty.isEmpty == false) ? variantToShow!.packQty : (availableVariants.first?.packQty ?? "")

                        let packQtyVal = Double(packQty) ?? 0.0
                        let stockVal = Double("\(product.totalStock)") ?? 0.0
                        let isVariantOutOfStock = packQtyVal > stockVal

                        NavigationLink(value: ProductNavigationContext(
                            product: product,
                            relatedProducts: products,
                            moduleId: moduleId
                        )) {
                            ProductCards(
                                productId: product.id,
                                variantId: String(variantToShow?.variantId ?? 0),
                                scheme: variantToShow?.scheme ?? "",
                                thumbnail: variantToShow?.variantImage.thumbUrl ?? "",
                                title: product.productName,
                                packQuantity: packQty,
                                options: actualOptionsCount,
                                mrp: variantToShow?.mrp ?? "",
                                salePrice: variantToShow?.salePrice ?? "",
                                cardSize: 130,
                                isOutOfStock: isVariantOutOfStock,
                                onOptionsTapped: {
                                    onOptionTap?(product)
                                },
                                isLoading: isLoading
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
            }
            .padding(.vertical, -4)
        }
    }
}

struct BrandGridModule: View {
    let title: String
    let brands: [FeaturedBrandItem]

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            HStack {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color.black)

                Spacer()

                NavigationLink(value: AppRoute.seeAllBrands) {
                    HStack(spacing: 4) {
                        Text("See all")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(Color(hex: "#53B175"))

                        Image(systemName: "chevron.right")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(Color(hex: "#53B175"))
                    }
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 16)

            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(brands.prefix(12), id: \.brandId) { brand in

                    NavigationLink(value: BrandProductNavigationContext(brandId: Int(brand.id) ?? 49)) {
                        VStack(spacing: 8) {
                            KFImage(URL(string: brand.image))
                                .placeholder {
                                    Circle()
                                        .fill(Color.gray.opacity(0.1))
                                        .frame(height: 60)
                                        .overlay(ProgressView())
                                }
                                .setProcessor (
                                    DownsamplingImageProcessor(size: CGSize(width: 200, height: 200))
                                )
                                .scaleFactor(UIScreen.main.scale)
                                .cacheOriginalImage()
                                .resizable()
                                .frame(height: 60)
                                .padding(8)
                                .background(Color.white)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                )


                            Text(brand.brandName)
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(Color.black)
                                .multilineTextAlignment(.center)
                                .lineLimit(1)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
        }
    }
}
