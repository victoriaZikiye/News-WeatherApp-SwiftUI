
import SwiftUI

struct NewsTabView: View {
    @StateObject var articleNewsVM = ArticleNewsViewModel()
    var body: some View {
        NavigationView{
            ArticleListView(articles: articles)
                .overlay(overlayView)
                .refreshable {
                    loadTask()
                }
                .onAppear{
                    loadTask()
                }
                .onChange(of: articleNewsVM.selectedCategory){ _ in
                    loadTask()
                }
                .navigationTitle(articleNewsVM.selectedCategory.text)
                .navigationBarItems(trailing: menu)
        }
    }
    
    private var articles:[Article]{
        if case let .success(articles) = articleNewsVM.phase{
            return articles
        }
        else{
            return []
        }
    }
    
    private func loadTask(){
        Task.init{
            await articleNewsVM.loadArticles()
        }
    }
    
    private var menu: some View{
        Menu {
            Picker("Category", selection: $articleNewsVM.selectedCategory) {
                ForEach(Category.allCases){
                    Text($0.text).tag($0)
                }
            }
        } label: {
            Image(systemName: "fiberchannel")
                .imageScale(.large)
        }

    }
    
    
    
    @ViewBuilder
    private var overlayView: some View{
        switch articleNewsVM.phase{
        case .empty :
            ProgressView()
        case .success(let articles) where articles.isEmpty:
            EmptyPlaceholderView(text: "No Article Found!", image: nil)
        case .failure(let error):
            RetryView(text: error.localizedDescription) {
                loadTask()
            }
        default: EmptyView()
        }
    }
}

