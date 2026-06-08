library(shiny)
library(ggplot2)
library(ggrepel)

# 1. Define the User Interface
ui <- fluidPage(
  titlePanel("Benchmark of Annotations in OCDCTD cohort"),
  
  sidebarLayout(
    sidebarPanel(
      checkboxInput(
        "sig_only",
        "Show only significant points (p <= 0.1)",
        value = FALSE
      ),
      
      checkboxInput(
        "maxOR",
        "Show Max OR for each Annotation",
        value = FALSE
      ),
      checkboxInput(
        "maxCase",
        "Maximize the counts",
        value = FALSE
      ),
      
      checkboxInput(
        "show_labels",
        "Show labels",
        value = FALSE
      ),
      
      fluidRow(
        column(
          6,
          actionButton("select_all", "Select All")
        ),
        column(
          6,
          actionButton("clear_all", "Clear All")
        )
      ),
      checkboxGroupInput(
        "annotations",
        "Annotations",
        choices = sort(unique(ocd_results$annotation)),
        selected = sort(unique(ocd_results$annotation))
      )
    ),
    
    mainPanel(
      # Visual placeholder for the final plot layout
      plotOutput(outputId = "scatter_plot",height = "600px")
    )
  )
)

# 2. Define the Server Logic
server <- function(input, output,session) {
  
  all_annotations <- sort(unique(ocd_results$annotation))
  
  observeEvent(input$select_all, {
    updateCheckboxGroupInput(
      session,
      "annotations",
      selected = all_annotations
    )
  })
  
  observeEvent(input$clear_all, {
    updateCheckboxGroupInput(
      session,
      "annotations",
      selected = character(0)
    )
  })
  
  plot_data <- reactive({
    
    df <- ocd_results %>%
      mutate(
        sig = p.value <= 0.1,
        logp = -log10(p.value)
      ) %>%
      filter(annotation %in% input$annotations)%>%
      filter(annotation != "stop",annotation != "ptv", annotation != "inframe",
             annotation != "start", annotation != "synonymous", annotation != "splice",
             annotation != "totalnVar", annotation != "NA", annotation != "missense")
    
    if (input$sig_only) {
      df <- df %>% filter(sig)
    }
    
    if (input$maxOR) {
      df <- df %>%
        mutate(estimate = if_else(is.infinite(estimate), 0, estimate)) %>%
        group_by(annotation) %>%
        slice_max(estimate)
    }
    
    if (input$maxCase) {
      df <- df %>%
        group_by(annotation) %>%
        slice_max(case_mut_count)
    }
    
    df
  })
  
  output$scatter_plot <- renderPlot({
    
    p <- plot_data() %>%
      ggplot(aes(x = estimate, y = case_mut_count)) +
      geom_point(aes(color = annotation), size = 3) +
      geom_vline(xintercept = 1, linetype = "dashed") +
      labs(
        x = "Odds Ratio",
        y = "Mutant Case Count"
      ) +
      # coord_cartesian(xlim = c(0, 12)) +
      theme_minimal()
    
    if (input$show_labels) {
      p <- p +
        ggrepel::geom_text_repel(
          aes(label = mutype),
          size = 3,
          max.overlaps = Inf
        )
    }
    
    p
    
  })
}

# 3. Combine UI and Server to Run the App
shinyApp(ui = ui, server = server)
